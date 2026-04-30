import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";
import { VERSION } from "@mariozechner/pi-coding-agent";

export default function (pi: ExtensionAPI) {
  pi.on("session_start", async (_event, ctx) => {
    if (ctx.hasUI) {
      ctx.ui.setHeader((_tui, theme) => {
        const b = (text: string) => theme.fg("accent", text);
        const dim = (text: string) => theme.fg("dim", text);
        const muted = (text: string) => theme.fg("muted", text);

        const lines = [
          "",
          `  ${b("██████")}    ${b("pi")} ${dim(`v${VERSION}`)}`,
          `  ${b("██  ██")}    ${muted("escape")} interrupt · ${muted("/")} commands · ${muted("!")} bash`,
          `  ${b("████  ██")}  ${muted("ctrl+c/ctrl+d")} clear/exit`,
          `  ${b("██    ██")}  ${muted("ctrl+p")} cycle models · ${muted("ctrl+t")} cycle thinking`,
          "",
          `  Pi can explain its own features and look up its docs. Ask it how to use or extend Pi.`,
          "",
        ];

        return {
          render(_width: number) { return lines; },
          invalidate() {},
        };
      });
    }
  });
}
