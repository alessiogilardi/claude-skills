# Chapter 31: The Web Is a Detail

## Core Idea
The web is an I/O device — just the latest oscillation in the decades-long pendulum between centralized and distributed computing; business logic must be isolated from UI/web delivery mechanisms because marketing geniuses will always want to change the UI.

## Frameworks Introduced
- **UI as I/O Device**: The web/GUI is an I/O mechanism, like a disk or console — it can be swapped without changing business logic if boundaries are drawn correctly.
  - When to use: When evaluating how deeply to couple business rules to the current UI technology.
  - How: Define use cases as input-data → process → output-data; the UI's job is to collect input data and display output data. The use case doesn't know which UI is in use.

## Key Concepts
- **The Pendulum**: Computing has oscillated for decades — mainframes with dumb terminals → minicomputers with smart terminals → client-server → web (server-side) → applets → server-side again → Ajax/Web 2.0 → Node.js pulling JS back to server. The web is one swing in this endless pendulum.
- **Company Q lesson**: A personal finance desktop app redesigned to look like a browser (because "web") — users hated it; eventually reverted. Marketing pressure on UI is constant and irrational. Business rules should be insulated.
- **The web is a GUI; the GUI is a detail**: "GUI is a detail. The web is a GUI. So the web is a detail."
- **Practical limit of abstraction**: The specific dance between a browser and a server is harder to fully abstract than a simple device interface. But the use case layer can still be independent — input data in, output data out, with the delivery mechanism responsible for the dance.
- **Device independence principle (1960s)**: Applications written to be device-independent can be delivered to any device. The web doesn't break this principle — it is just another device.

## Mental Models
- Think of the web server as the "driver" of the web I/O device, same as a disk driver for a disk. Your business logic should not depend on the driver.
- The marketing genius will always come. Build your architecture to survive the next platform shift.

## Anti-patterns
- **Business logic in JSP/Django templates/React components**: The UI now contains business decisions — any UI change requires business logic changes.
- **HTTP-aware use cases**: Use cases that accept `HttpRequest`, return `HttpResponse`, or know about REST endpoints.
- **Full re-architecture for each UI paradigm shift**: If a new UI requires rewriting core business logic, the architecture failed.

## Key Takeaways
1. The web is one oscillation in a 60-year pendulum — it will be replaced by the next oscillation.
2. Business rules must be isolated from the web delivery mechanism behind clean use case boundaries.
3. The web is an I/O device; treat it like one — keep it in the outermost ring.
4. Use cases receive plain input data, produce plain output data — the UI handles the rest.
5. Architecture that depends on the web will require rewriting when the web is replaced.

## Connects To
- **Ch 21**: Screaming Architecture — the web should not dominate the top-level structure.
- **Ch 22**: Web framework lives in the outermost ring; use cases are unaware of it.
- **Ch 23**: Presenter/View split insulates business logic from the specific web UI rendering.
