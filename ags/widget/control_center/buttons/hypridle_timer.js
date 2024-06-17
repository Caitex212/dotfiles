import QsButton from "./qs_button.js";

export default () =>
  QsButton({
    icon: "clock",
    label: "Idle Timer",
    on_clicked: () => {
      Utils.timeout(200, () => {
        Utils.execAsync('/home/niels/.config/ags/widget/control_center/buttons/hypridle_file.sh')
          .catch(print);
      });
    },
  });