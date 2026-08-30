import app from "ags/gtk4/app"
import GLib from "gi://GLib"
import Astal from "gi://Astal?version=4.0"
import Gtk from "gi://Gtk?version=4.0"
import Gdk from "gi://Gdk?version=4.0"
import AstalBattery from "gi://AstalBattery"
import AstalWp from "gi://AstalWp"
import AstalNetwork from "gi://AstalNetwork"
import AstalBluetooth from "gi://AstalBluetooth"
import AstalHyprland from "gi://AstalHyprland"

import { For, With, createBinding, createComputed, createState, onCleanup } from "ags"
import { exec } from "ags/process"
import { createPoll } from "ags/time"
import { createSubprocess } from "ags/process"

const spacingImageText = 'margin-left: 3px;'

const clamp = (min: number, value: number, max: number): number => {
  return value < min ? min : value > max ? max : value
}

// For debug purposes
const dbg = (val: any, name?: string) => {
  if (name) {
    console.log(`--- ${name} ---`)
  }
  console.log(`:::: ${val}`)
  return val
}

function Tray() {
  const hyprland = AstalHyprland.get_default()
  const workspaces = createBinding(hyprland, "workspaces")
  const active = createBinding(hyprland, "focusedWorkspace")

  const comparer = (n1: number, n2: number) => {
    // Leaving this as such if I ever want to have something like "<<+>>" and not only "--+--"
    if (n1 < n2) {
        return "󰽤"
    } else if (n1 === n2) {
        return "󰽢"
    } else {
        return "󰽤"
    }
  }

  return (
    <menubutton>
      <box orientation={Gtk.Orientation.HORIZONTAL}>
        <For each={createComputed(() => workspaces().sort((w1, w2) => w1.id - w2.id))}>
          {
            workspace => (
              <box widthRequest={12}>
                <label label={createComputed(() => comparer(workspace.id, active().id))} css='color: lightblue;' />
              </box>
            )
          }
        </For>
      </box>
      <popover />
    </menubutton>
  )
}

function ActiveWindow() {
  const hyprland = AstalHyprland.get_default()
  const active = createBinding(hyprland, "focusedWorkspace", "clients")

  return (
    <menubutton>
      <label label={createComputed(() => `${active().length}`)} css='color: yellow;' />
      <popover />
    </menubutton>
  )
}

function Focused()  {
  const hyprland = AstalHyprland.get_default()
  const title = createBinding(hyprland, "focusedClient", "title")
  const classW = createBinding(hyprland, "focusedClient", "class")

  const font = `
    font-family: Fira Code;
  `

  return (
    <menubutton>
      <label label={createComputed(() => `${title() ?? "None"}`)} maxWidthChars={20} ellipsize={3} css={font} />
      <popover>
        <label label={createComputed(() => `${classW() ?? "None"}`)} maxWidthChars={20} ellipsize={3} css={font} />
      </popover>
    </menubutton>
  )
}

function Submap() {
  const hyprland = AstalHyprland.get_default()
  const [sbm, ssbm] = createState("default")
  const con = hyprland.connect("submap", (self: any, name: string) => ssbm(!name ? "default" : name))

  const css = `
    color: rgb(250, 128, 114);
    font-family: Fira Code;
  `

  onCleanup(() => hyprland.disconnect(con))

  return (
    <menubutton>
      <label label={createComputed(() => sbm())} css={css} />
      <popover />
    </menubutton>
  )
}

function Keyboard() {
  const hyprland = AstalHyprland.get_default()
  const [kb, skb] = createState(exec(
    "bash -c 'hyprctl devices -j | jq \'.keyboards[0].active_keymap\' -r '"
  ))
  const [kbs, skbs] = createState("")

  const con = hyprland.connect("keyboard-layout", (self: any, keyboard: string, layout: string) => {
    skb(`  ${layout}`)
    skbs(`Keyboard: ${keyboard}`)
  })

  onCleanup(() => hyprland.disconnect(con))

  return (
    <menubutton>
      <label label={createComputed(() => kb())} />
      <popover>
        <label label={createComputed(() => kbs())} />
      </popover>
    </menubutton>
  )
}

function Bluetooth() {
  const bluetooth = AstalBluetooth.Bluetooth.get_default()
  const devices = createBinding(bluetooth, "devices")
  const powered = createBinding(bluetooth, "isPowered")

  const icon = createComputed(() => powered() ? "󰂱" : "󰂲")
  const state = createPoll(
    "",
    1000,
    () => {
      const basic = devices().filter(dev => dev.connected)
      return basic.length >= 1 ? `${basic[0].name} ${basic[0].battery_percentage * 100}% ` : "No device"
    }
  )

  return (
    <menubutton>
      <label label={createComputed(() =>`${icon()} ${state()}`)} css='color: rgb(135, 206, 235);' />
      <popover>
        <box orientation={Gtk.Orientation.VERTICAL}>
          <box orientation={Gtk.Orientation.VERTICAL} heightRequest={20}>
            <label label="List of discovered devices" />
          </box>
          <box orientation={Gtk.Orientation.HORIZONTAL}>
            <box widthRequest={100} hexpand={false} css='border-bottom: 1px solid grey;'>
              <label label="Name" justify={Gtk.Justification.CENTER} css='font-style: italic;' />
            </box>
            <box widthRequest={50} hexpand={false} />
            <box widthRequest={100} hexpand={false} css='border-bottom: 1px solid grey;'>
              <label label="IPv6 Address" justify={Gtk.Justification.CENTER} css='font-style: italic;' />
            </box>
          </box>
          <For each={devices}>
          {
            device => (
              <box orientation={Gtk.Orientation.HORIZONTAL}>
                <box orientation={Gtk.Orientation.HORIZONTAL} widthRequest={150} hexpand={false}>
                  <label label={device.get_name()} />
                </box>
                <box orientation={Gtk.Orientation.HORIZONTAL} widthRequest={100} hexpand={false}>
                  <label label={device.get_address()} />
                </box>
              </box>
            )
          }
          </For>
        </box>
      </popover>
    </menubutton>
  )
}

function Github() {
  const script = `
  bash -c '
    ping 8.8.8.8 -c 1 > /dev/null;
    if [[ $? == 0 && $(command -v gh) ]]; then
      gh api -H "Accept: application/vnd.github+json" -H "X-GitHub-Api-Version: 2026-03-10" '/notifications' | cat;
    else
      echo '[]';
    fi;
  '
  `
  const poll = createPoll("", 60000, script)
  const [gjson, sjson] = createState([])

  poll.subscribe(() => {
      const rawJson = poll.get();
      const json = !rawJson ? [] : JSON.parse(rawJson) as any[]
      sjson(json)
      sicon(json.length !== 0 ? "󱅫" : "")
  })

  const [gicon, sicon] = createState("")

  return (
    <menubutton>
      <label label={createComputed(() => `${gicon()} ${gjson().length}`)} css='color: rgb(138, 43, 226);' />
      <popover>
        <With value={gjson}>
          {
            item => {
              return (
                <box orientation={Gtk.Orientation.VERTICAL}>
                  {
                    item.map(value => (
                      <box orientation={Gtk.Orientation.HORIZONTAL} widthRequest={200}>
                        <box widthRequest={100} hexpand={false}>
                          <label css="font-weight: bold; color: cyan;" label={`${value.reason}`} />
                        </box>
                        <label label="@" css='margin: 0px 20px 0px 20px;' />
                        <box widthRequest={100} hexpand={false}>
                          <label css="font-weight: bold; color: red;" label={`${value.repository.name}`} />
                        </box>
                        <label label="-" css='margin: 0px 20px 0px 20px;' />
                        <box widthRequest={200} hexpand={false}>
                          <label css="font-weight: bold; color: orange;" maxWidthChars={20} ellipsize={3} label={`${value.subject.title}`} />
                        </box>
                      </box>
                    ))
                  }
                </box>
              )
            }
          }
        </With>
      </popover>
    </menubutton>
  )
}

function Network() {
  const network = AstalNetwork.get_default()
  const primaryRef = createBinding(network, "primary")
  const connectivityRef = createBinding(network, "connectivity")
  const ssid = createBinding(network.wifi, "ssid")
  const strength = createBinding(network.wifi, "strength")
  const customIcons = [
    "󰤯",
    "󰤟",
    "󰤢",
    "󰤥",
    "󰤨"
  ]
  const conn = [
    "Unknown",
    "None",
    "Portal",
    "Limited",
    "Full"
  ]

  const icon = (strength: number) => customIcons[Math.floor(strength * (customIcons.length - 1) / 100)]

  const format = createComputed(() => {
    const primary = primaryRef()
    const ssidV = ssid()
    const strengthV = strength()

    if (connectivityRef() === AstalNetwork.Connectivity.NONE) {
      return "󰤮 Disconnected"
    }

    switch (primary) {
      case AstalNetwork.Primary.UNKNOWN:
        return " Unknown"
      case AstalNetwork.Primary.WIRED:
        return "󰈀 Wired"
      case AstalNetwork.Primary.WIFI:
          return `${icon(strengthV)} ${ssidV}`
      default:
          throw "Should never happen"
    }
  })

  return (
    <menubutton>
      <label label={format} css='color: rgb(192, 192, 192);' />
      <popover>
        <label label={connectivityRef((value: number) => `Connectivity: ${conn[value]}, Stength: ${strength()}%`)} />
      </popover>
    </menubutton>
  )
}

function Temperature() {
  const temperature = createPoll("", 1000, "acpi --thermal")
  const customIcons = [
    "",
    "",
    "",
    "",
    "",
    ""
  ]

const getTemp = (input: string): number => {
    try {
      return parseFloat(input.split(/\s+/)[3])
    } catch (error) {
      return 0
    }
  }

  const icon = (dg: number | undefined): string => {
    if (dg === undefined) {
      return ""
    }

    dg = clamp(0, dg, 110)
    return customIcons[Math.floor(dg * (customIcons.length - 1) / 110)]
  }

  const frh = (dg: number): number => dg * 9 / 5 + 32

  return (
    <menubutton>
      <label label={temperature((input: string) => { const temp = getTemp(input); return `${icon(temp)} ${temp}°C` })} css='color: rgb(220, 20, 60);' />
      <popover>
        <label label={temperature((input: string) => `${frh(getTemp(input))}°F`)} />
      </popover>
    </menubutton>
  )
}

function AudioOutput() {
  const { defaultSpeaker: speaker } = AstalWp.get_default()!
  const binding = createBinding(speaker, "volume")
  const mute = createBinding(speaker, "mute")

  const css = `
    font-style: italic;
    font-weight: bold;
    color: rgb(105, 105, 105);
  `

  const customIcons = [
    "pp",
    "p",
    "mp",
    "mf",
    "f",
    "ff",
  ]

  const showIcon = createComputed((): string => {
    if (mute()) {
      return "x"
    }

    return customIcons[Math.floor(binding() * 5)]
  })

  const showPercentage = (pfl: number) => {
    return `${Math.floor(pfl * 100)}%`
  }

  return (
    <menubutton>
      <box>
        <label label={showIcon} css={css} />
        <label label={binding(showPercentage)} css={spacingImageText + 'color: rgb(105, 105, 105);'} />
      </box>
      <popover>
        <label label={createBinding(speaker, "name")(name => name ?? "No device")} />
      </popover>
    </menubutton>
  )
}

function Cpu() {
  const poll = createPoll("", 2000, "top -b -n 1")

  const parseIdle = (input: string): number => {
    try {
      return parseFloat(input.split('\n')[2].split(/\s+/)[7])
    } catch (error) {
      return 0
    }
  }

  const numTasks = (input: string): string  => {
    try {
      const split = input.split('\n')[1].split(/\s+/)
      return `${split[1]} tasks, ${split[3]} running`
    } catch (error) {
      return '0 tasks, 0 running'
    }
  }

  return (
    <menubutton>
      <label
        label={poll((input: string) => `󰍛 ${Math.floor(100 - parseIdle(input))}%`)}
        css='color: rgb(0, 139, 139);'
      />
      <popover>
        <label label={poll(numTasks)} />
      </popover>
    </menubutton>
  )
}

function Notifications() {
  const notifs = createSubprocess("", "notifs-piper watch");

  return (
    <menubutton>
      <label label={notifs(
        (input: string): string => {
          if (input.substring(0, 3) === "res") {
              return JSON.parse(input.substring(4)).summary;
          }

          return ""
        }
      )}
      />
    </menubutton>
  )
}

function Memory() {
  const poll = createPoll("", 1000, "free")

  const parse = (input: string): [number, number] | undefined => {
    const split = input.split('\n')[1]
    if (!split) {
      return undefined
    }

    return split.split(/\s+/).slice(1, 3).map((val: string) => parseInt(val)) as [number, number]
  }

  const percent = (input: string): string => {
    const [total, used] = parse(input) ?? [undefined, undefined]
    return ` ${total !== undefined ? Math.floor(used * 100 / total) : 0}%`
  }

  const used = (input: string): string => `Using ${Math.floor((parse(input) ?? [0, 0])[1] / 1024)} MiB`

  return (
    <menubutton>
      <label label={poll(percent)} css='color: rgb(240, 128, 128);' />
      <popover>
        <label label={poll(used)} />
      </popover>
    </menubutton>
  )
}

function Battery() {
  const battery = AstalBattery.get_default()
  const device = AstalBattery.Device.get_default()

  const customIcons: string[] = [
    "",
    "",
    "",
    "",
    ""
  ]

  const getImage = (pfl: number): string => {
    return (
      battery.get_state() === AstalBattery.State.CHARGING ? "󰚥 " : ""
    ) + customIcons[Math.floor(pfl * (customIcons.length - 1))]
  }

  const percent = createBinding(
    battery,
    "percentage",
  )((pfl: number) => `${getImage(pfl)} ${Math.floor(pfl * 100)}%`)


  const getTimeLeft = () => {
      let minutes = undefined
      switch (device?.get_state()) {
        case AstalBattery.State.CHARGING:
            minutes = Math.floor(device.get_time_to_full() / 60)
            return `Time to full : ${Math.floor(minutes / 60)} hours ${minutes % 60} minutes`
        case AstalBattery.State.DISCHARGING:
            minutes = Math.floor(device.get_time_to_empty() / 60)
            return `Time to empty : ${Math.floor(minutes / 60)} hours ${minutes % 60} minutes`
        case AstalBattery.State.FULLY_CHARGED:
            return `Battery full`
        default:
            return ``
      }
  }

  return (
    <menubutton visible={createBinding(battery, "isPresent")}>
      <box>
        <label label={percent} css={spacingImageText + 'color: rgb(30, 144, 255);'} />
      </box>
      <popover>
        <label label={createPoll("", 1000, getTimeLeft)} />
      </popover>
    </menubutton>
  )
}

function Clock({ format = "%a   %H:%M   %d·%m" }) {
  const time = createPoll("", 1000, () => {
    return GLib.DateTime.new_now_local().format(format)!
  })

  return (
    <menubutton>
      <label label={time} css='font-weight: bold;' />
      <popover>
        <Gtk.Calendar />
      </popover>
    </menubutton>
  )
}

function Left() {
  return (
    <Gtk.Image file='./icons/left.svg' css='margin-right: -11px;' iconSize={Gtk.IconSize.LARGE} />
  )
}

function Mid() {
  return (
    <label label=" │ " />
  )
}

function Right() {
  return (
    <Gtk.Image file='./icons/right.svg' css='margin-left: -11px;' iconSize={Gtk.IconSize.LARGE} />
  )
}

export default function Bar({ gdkmonitor }: { gdkmonitor: Gdk.Monitor }) {
  let win: Astal.Window
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  const color = `
    background-color: rgba(36, 40, 59, 0.9);
  `

  const colorPadding = `
   ${color}
    padding: 0px 2px 0px 2px;
  `

  onCleanup(() => {
    win.destroy()
  })

  return (
    <window
      $={(self) => (win = self)}
      visible
      namespace="top-bar"
      name={`bar-${gdkmonitor.connector}`}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      marginTop={3}
      application={app}
      css='background-color: transparent;'
    >
      <centerbox>
        <box $type="start">
          <box>
            <Left />
            <box css={colorPadding}>
              <Tray />
              <Mid />
              <ActiveWindow />
              <Mid />
              <Focused />
            </box>

            <box hexpand={true} css={color} />

            <box css={color + 'padding-left: 2px;'}>
              <Temperature />
              <Mid />
              <Cpu />
              <Mid />
              <Memory />
              <Mid />
            </box>
          </box>
        </box>

        <box $type="center" css={color}>
          <Clock />
        </box>

        <box $type="end">
          <box>
            <box css={color + 'padding-right: 2px;'}>
              <Mid />
              <Battery />
              <Mid />
              <AudioOutput />
              <Mid />
              <Github />
              <Notifications css='    opacity: 0;
    margin-top: -20px;
    transition:
        opacity 300ms ease,
        margin-top 500ms ease;' />
            </box>
  
            <box hexpand={true} css={color} />
  
            <box css={colorPadding}>
              <Submap />
              <Mid />
              <Keyboard />
              <Mid />
              <Bluetooth />
              <Mid />
              <Network />
            </box>
            <Right />
          </box>
        </box>
      </centerbox>
    </window>
  )
}
