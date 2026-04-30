import type { ExtensionAPI } from "@mariozechner/pi-coding-agent";

const MESSAGES = [
  "Winding the clockwork",
  "Shuffling the papers",
  "Harnessing the invisible forces",
  "Summoning the aetheric currents",
  "Pondering the YAML",
  "Consulting the void",
  "Almost certainly working",
  "Breaking in new machinery",
  "The abacus demands sacrifice",
  "Teaching the code proper etiquette",
  "Ensuring good posture",
  "Teaching YAML proper posture",
  "One mustn't rush these matters",
  "The results are about to be presented to society",
  "Airing out the algorithms",
  "Dusting the interfaces",
  "Deportment lessons for the clusters",
  "Sending indentation errors into the corner",
  "Giving it a proper dusting",
  "The algorithms are practicing their curtsy",
  "Taking tea with the database",
  "Consulting etcd on suitable bachelors",
  "Begging your pardon for the wait",
  "Your data shall be presentable shortly",
  "Someone must tidy up this code",
  "Tiptoeing through the codebase",
  "Scrubbing the data center floors",
  "Polishing the copper wires",
  "Folding the bandwidth",
  "Airing the memory lanes",
  "Results will be marked in red ink",
  "Begging your pardon for the wait",
  "A thoroughly proper sort of computation",
  "Appeasing the gods",
  "Polishing the sockets",
  "Offering snacks to the linter",
  "Decompressing thoughts",
  "Assembling breadcrumbs",
  "Negotiating with entropy",
  "Refactoring reality",
  "One does not rush these processes",
];

const DOT_FRAMES = [".  ", ".. ", "...", " ..", "  .", "   "];
const SPINNER_FRAMES = ["⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏"];

function pick(): string {
 return MESSAGES[Math.floor(Math.random() * MESSAGES.length)]!;
}

export default function (pi: ExtensionAPI) {
  pi.on("agent_start", async (_event, ctx) => {
    const msg = pick();
    ctx.ui.setWorkingMessage(" ");
    ctx.ui.setWorkingIndicator({
      frames: DOT_FRAMES.map((dots, i) =>
        ctx.ui.theme.fg("muted", `${SPINNER_FRAMES[i % SPINNER_FRAMES.length]} ${msg}${dots}`)
      ),
      intervalMs: 150,
    });
  });
}
