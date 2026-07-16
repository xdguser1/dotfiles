import app from 'ags/gtk4/app'
import { createBinding, For, This } from 'ags'

import Bar from './Bar.tsx'

const css = `
  button {
    margin: 0px 1px 0px 1px;
    background-color: transparent;
    border: none;
  }
` 

app.start(
  {
    instanceName: 'top-bar',
    gtkTheme: 'Nordic',
    css: css,
    main() {
      const monitors = createBinding(app, 'monitors')
      return (
        <For each={monitors}>
          {(monitor) =>(
            <This this={app}>
              <Bar gdkmonitor={monitor} />
            </This>
          )}
        </For>
      )
    },
  }
)
