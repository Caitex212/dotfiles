import { configs } from "../../vars.js";
import { isVertical } from "../../functions/utils.js";
const systemtray = await Service.import("systemtray");

function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            vertical: configs.theme.bar.position.bind().as(isVertical),
            child: Widget.Icon({ 
                class_names: [
                    "systray__item",
                    "tray-button",
                    ], 
                icon: item.bind("icon"),
                size: 18,
                setup: (self) => {
                    self.hook(configs.theme.bar.position, () => {
                      self.toggleClassName(
                        "vert",
                        isVertical(configs.theme.bar.position.value),
                      );
                      self.toggleClassName(
                        "hort",
                        !isVertical(configs.theme.bar.position.value),
                      );
                    });
                },
                vpack: "center",
                hpack: "center",
            }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        spacing: configs.theme.bar.button_spacing.bind(),
        children: items,
    })
}

export default () =>
    Widget.Box({
        class_names: ["systray__container"],
        children: [
            SysTray(),
        ],
    });
