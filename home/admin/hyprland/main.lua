launch = {
    calc      = "qalculate-qt",
    code      = "kitty bash -c 'fzf | xargs nvim'",
    firefox   = "firefox",
    finder    = "kitty superfile",
    hibernate = "systemctl hibernate",
    img       = "inkscape",
    lock      = "hyprlock",
    notes     = "xournalpp",
    office    = "libreoffice",
    pdf       = "okular",
    picker    = "hyprpicker -a",
    poweroff  = "systemctl poweroff",
    reboot    = "systemctl reboot",
    status    = "kitty btop",
    term      = "kitty",
    tex       = "texstudio",
    zen       = "flatpak run app.zen_browser.zen",
    screenshot = {
        region = "hyprshot -z -m region --clipboard-only",
        screen = "hyprshot -z -m output --clipboard-only",
        window = "hyprshot -z -m window --clipboard-only",
        save = {
            region = "hyprshot -z -m region --clipboard-only -o ~/images/screenshots",
            screen = "hyprshot -z -m output --clipboard-only -o ~/images/screenshots",
            window = "hyprshot -z -m window --clipboard-only -o ~/images/screenshots",
        },
    },
}

mods = {
    main = "SUPER",
    opt1 = "SUPER + SHIFT",
    opt2 = "SUPER + CONTROL",
    opt3 = "SUPER + ALT",
    opt4 = "SUPER + SHIFT + CONTROL",
    raw  = {
        main = "SUPER",
        opt1 = "SHIFT",
        opt2 = "CONTROL",
        opt3 = "ALT",
        opt4 = "SHIFT + CONTROL",
    },
    layout = {
        main = "ALT",
        opt1 = "SHIFT + ALT",
    },
    start  = "CONTROL + ALT",
    start1 = "CONTROL + ALT + SHIFT",
}


gen_directions = function(fn)
    return {
        right = fn("right"),
        left  = fn("left"),
        up    = fn("up"),
        down  = fn("down"),
    }
end

gen_num = function(fn, start, finish)
    if start >= finish then
        return nil
    end

    local append = {}

    for i=start,finish do
        append[i] = fn(i)
    end

    return append
end

table_to_list = function(tb)
    local ret = {}
    local counter = 1

    for _,v in pairs(tb) do
        ret[counter] = v
        counter = counter + 1
    end

    return ret
end

append_list = function(first, second)
    local offset = #first + 1

    for i=offset,(offset + #second) do
        first[i] = second[i - offset + 1]
    end

    return first
end

append_lists = function(lists)
    local append = {}

    for i,v in ipairs(lists) do
        append_list(append, lists[i])
    end

    return append
end

build_ex = function(cmd, flags)
    return {
        cmd   = cmd,
        flags = flags,
    }
end

bindings = {
    exec_cmd = {
        { mods.main .. " + space", build_ex("sh ~/.config/switchkb.sh"), {}, },
        { "XF86AudioRaiseVolume", build_ex("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true, }, },
        { "XF86AudioLowerVolume", build_ex("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true, }, },
        { "XF86AudioMute", build_ex("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true, repeating = true, }, },
        { "XF86AudioMicMute", build_ex("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true, }, },
        { "XF86MonBrightnessUp", build_ex("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true, }, },
        { "XF86MonBrightnessDown", build_ex("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true, }, },
        { "XF86AudioNext", build_ex("playerctl next"), { locked = true, }, },
        { "XF86AudioPrev", build_ex("playerctl previous"), { locked = true, }, },
        { "XF86AudioPlay", build_ex("playerctl play"), { locked = true, }, },
        { "XF86AudioPause", build_ex("playerctl pause"), { locked = true, }, },
        { mods.raw.opt3 .. " + V", build_ex("bash -c 'if [ -z `pgrep clipse`]; then kitty --class clipse -e clipse; fi;'"), {}, },
        { mods.start .. " + K", build_ex(launch.pdf, { fullscreen_state = 0, }), },
        { mods.start .. " + B", build_ex(launch.status), {}, },
        { mods.start .. " + C", build_ex(launch.code), {}, },
        { mods.start .. " + G", build_ex(launch.img, { fullscreen_state = 0, }), },
        { mods.start .. " + L", build_ex(launch.office, { fullscreen_state = 0, }), },
        { mods.start .. " + P", build_ex(launch.picker), {}, },
        { mods.start .. " + Q", build_ex(launch.calc, { fullscreen_state = 0, }), },
        { mods.start .. " + E", build_ex(launch.notes, { fullscreen_state = 0, }), },
        { mods.start .. " + S", build_ex(launch.screenshot.region), {}, },
        { mods.start .. " + T", build_ex(launch.term), {}, },
        { mods.start .. " + X", build_ex(launch.tex, { fullscreen_state = 0, }), },
        { mods.start .. " + Z", build_ex(launch.zen, { fullscreen_state = 0, }), },
        { mods.start .. " + slash", build_ex(launch.finder), {}, },
        { mods.start .. " + Shift_L + slash", build_ex(launch.firefox, { fullscreen_state = 0, }), },
        { mods.main .. " + T", build_ex(launch.term), {}, },
        { mods.main .. " + L", build_ex(launch.lock), {}, },
        { mods.main .. " + R", build_ex(launch.reboot), {}, },
        { mods.main .. " + O", build_ex(launch.poweroff), {}, },
        { mods.main .. " + H", build_ex(launch.hibernate), {}, },
    },

    window = {
        move = append_lists({
            {
                { mods.opt2 .. " + right", { x = 10, y = 0, relative = true, }, { repeating = true, }, },
                { mods.opt2 .. " + left", { x = -10, y = 0, relative = true, }, { repeating = true, }, },
                { mods.opt2 .. " + up", { x = 0, y = -10, relative = true, }, { repeating = true, }, },
                { mods.opt2 .. " + down", { x = 0, y = 10, relative = true, }, { repeating = true, }, },
                { mods.opt2 .. " + period", { workspace = "r+1", focus = true, }, {}, },
                { mods.opt2 .. " + comma", { workspace = "r-1", focus = true, }, {}, },
            },
            table_to_list(gen_directions(function(dir) return {
                mods.opt4 .. " + " .. dir,
                { direction = dir, group_aware = true, },
                {},
            } end)),
            gen_num(function(int) return {
                mods.opt2 .. string.format(" + %d", int % 10),
                { workspace = int, focus = true, },
                {},
            } end, 1, 11)
        }),
        resize = {
            { mods.opt1 .. " + right", { x = 10, y = 0, relative = true, }, { repeating = true, }, },
            { mods.opt1 .. " + left", { x = -10, y = 0, relative = true, }, { repeating = true, }, },
            { mods.opt1 .. " + up", { x = 0, y = 10, relative = true, }, { repeating = true, }, },
            { mods.opt1 .. " + down", { x = 10, y = -10, relative = true, }, { repeating = true, }, },
        },
        swap = table_to_list(gen_directions(function(dir) return {
            mods.opt3 .. " + " .. dir,
            { direction = dir, },
            {},
        } end)),
        focus = append_lists({
            table_to_list(gen_directions(function(dir) return {
                mods.main .. " + " .. dir,
                { direction = dir, },
                {},
            } end)),
            {
                { mods.main .. " + period", { workspace = "r+1" }, {}, },
                { mods.main .. " + comma", { workspace = "r-1" }, {}, },
            },
            gen_num(function(int) return {
                mods.main .. string.format("+ %d", int % 10),
                { workspace = int, },
                {},
            } end, 1, 11)
        }),
        other = {
            { mods.main .. " + mouse:273", hl.dsp.window.float(), { click = true, }, },
            { mods.main .. " + mouse:272", hl.dsp.window.close(), { click = true, }, },
            { mods.main .. " + TAB", hl.dsp.window.cycle_next({}), {}, },
            { mods.opt1 .. " + TAB", hl.dsp.window.cycle_next({ next = "prev", }), {}, },
            { mods.main .. " + Q", hl.dsp.window.close({}), {}, },
            { mods.opt1 .. " + Q", hl.dsp.window.kill({}), {}, },
            { mods.main .. " + F", hl.dsp.window.float({ action = "toggle", }), {}, },
            { mods.main .. " + P", hl.dsp.window.pin({}), {}, },
            { mods.main .. " +  C", hl.dsp.window.center({}), {}, },
            { mods.main .. " + equal", hl.dsp.window.fullscreen({ action = "toggle", }), },
            { mods.opt1 .. " + T", hl.dsp.group.toggle({}), {}, },
            { mods.opt1 .. " + L", hl.dsp.group.lock_active({ action = "toggle" }), {}, },
        },
    },

    layout = {
        { mods.layout.main .. " + C", "center", {}, },
        { mods.layout.opt1 .. " + left", "colresize -0.01", { repeating = true, }},
        { mods.layout.opt1 .. " + right", "colresize +0.01", { repeating = true, }, },
        { mods.layout.main .. " + bracketleft", "consume_or_expel prev", },
        { mods.layout.main .. " + bracketright", "consume_or_expel next", },
        { mods.layout.main .. " + equal ", "fit toend", {}, },
        { mods.layout.main .. " + period", "swapcol r", {}, },
        { mods.layout.main .. " + comma", "swapcol l", {}, },
        { mods.layout.main .. " + right", "move +10", { repeating = true, }, },
        { mods.layout.main .. " + left", "move -10", { repeating = true, }, },
    },

    other = {
        { mods.main .. " + Shift_L", hl.dsp.window.resize(), { mouse = true, }, },
        { mods.main .. " + Control_L", hl.dsp.window.drag(), { mouse = true, }, },
        { mods.raw.opt3 .. " + TAB", hl.dsp.group.next({}), {}, },
        { mods.raw.opt3 .. " + " .. mods.raw.opt1 .. " + TAB", hl.dsp.group.prev({}), {}, },
        { mods.start .. " + F", hl.dsp.submap("screenshots"), {}, },
        { mods.main .. " + E", hl.dsp.exit(), {}, },
    },
}

local gen_bind = function(set, dspfn)
    for _,v in ipairs(set) do
        hl.bind(v[1], dspfn(v[2]), v[3])
    end
end

id = function(arg) return arg end

gen_bind(bindings.exec_cmd, function(args) return hl.dsp.exec_cmd(args.cmd, args.flags) end)
gen_bind(bindings.window.move, hl.dsp.window.move)
gen_bind(bindings.window.resize, hl.dsp.window.resize)
gen_bind(bindings.window.swap, hl.dsp.window.swap)
gen_bind(bindings.window.focus, hl.dsp.focus)
gen_bind(bindings.window.other, id)
gen_bind(bindings.other, id)
gen_bind(bindings.layout, hl.dsp.layout)

hl.curve(
    "ease_out_cubic",
    {
        points = {
            {0.33, 1},
            {0.68, 1}
        },
        type = "bezier",
    }
)

hl.animation({
    bezier  = "ease_out_cubic",
    enabled = true,
    leaf    = "windows",
    speed   = 2,
    style   = "slide",
})

hl.config({
    binds = {
        drag_threshold = 10,
    },
    decoration = {
        active_opacity     = 0.9,
        dim_inactive       = true,
        dim_strength       = 0.25,
        fullscreen_opacity = 0.8,
        inactive_opacity   = 0.8,
        rounding           = 25,
        rounding_power     = 1,
    },
    general = {
        col = {
            active_border   = "0xcfC0C0C0",
            inactive_border = "0xcf808080",
        },
        gaps_in  = 2,
        gaps_out = 8,
        layout   = "scrolling",
    },
    gestures = {
        workspace_swipe_cancel_ratio = 0.3,
        workspace_swipe_distance     = 200,
    },
    group = {
        col = {
            border_active          = "0xcc0e9b63",
            border_inactive        = "0xcc0c734a",
            border_locked_active   = "0xcc961212",
            border_locked_inactive = "0xcc770e0e",
        },
        groupbar = {
            enabled = false,
        },
    },
    input = {
        accel_profile      = "flat",
        kb_layout          = "us,us,ca",
        kb_variant         = "colemak,,",
        numlock_by_default = true,
        repeat_delay       = 250,
        repeat_rate        = 40,
        scroll_method      = "2fg",
        sensitivity        = 0.4,
        touchpad = {
            natural_scroll = true,
            scroll_factor  = 0.75,
        },
    },
    misc = {
        font_family = "Ubuntu Nerd Font Medium",
    },
    xwayland = {
        force_zero_scaling = true,
    },
})

hl.define_submap("screenshots", function()
    local exec = function(cmd) return hl.dsp.exec_cmd(cmd) end
    hl.bind("F", exec(launch.screenshot.screen))
    hl.bind("S", exec(launch.screenshot.save.region))
    hl.bind("A", exec(launch.screenshot.save.screen))
    hl.bind("M", exec(launch.screenshot.window))
    hl.bind("N", exec(launch.screenshot.save.window))
    hl.bind("catchall", hl.dsp.submap("reset"))
end)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")

hl.gesture({
    action = "workspace",
    direction = "horizontal",
    fingers = 3,
    str = true,
})

hl.gesture({
    action    = function() hl.dispatch(hl.dsp.window.move({ workspace = "r+1", })) end,
    direction = "right",
    fingers   = 3,
    mods      = mods.main,
})

hl.gesture({
    action    = function() hl.dispatch(hl.dsp.window.move({ workspace = "r-1", })) end,
    direction = "left",
    fingers   = 3,
    mods      = mods.main,
})

hl.gesture({
    action    = function() hl.dispatch(hl.dsp.exec_cmd(lock)) end,
    direction = "down",
    fingers   = 4,
})

hl.gesture({
    action    = "fullscreen",
    direction = "up",
    fingers   = 4,
    str       = true,
})

hl.monitor({
    mode     = "preferred",
    output   = "",
    position = "auto",
    scale    = 1,
})

on_start = function(cmd, params)
    hl.on("hyprland.start", function() hl.exec_cmd(cmd, params) end)
end

on_start("ags run", {})
on_start("hyprctl setcursor 'Nordzy-cursors' 24", {})
on_start(launch.status, { workspace = "1 silent", })
on_start(launch.term, { workspace = "3 silent", })
on_start(launch.zen, { workspace = "2 silent", })

hl.window_rule({
    animation = "popin",
    float     = true,
    match = {
        class = "clipse",
    },
    pin  = true,
    size = "622 652",
})

if hl.plugin.dynamic_cursors then
    hl.config({
        plugin = {
            dynamic_cursors = {
                enabled   = true,
                mode      = "stretch",
                threshold = 2,

                stretch = {
                    limit      = 5000,
                    activation = "linear",
                    window     = 200,
                },

                shake = {
                    enabled = false,
                },

                hyprcursor = {
                    enabled    = true,
                    nearest    = 1,
                    resolution = -1,
                    fallback   = "clientside",
                },
            },
        },
    })
end
