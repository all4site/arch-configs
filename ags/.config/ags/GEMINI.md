# AGS Configuration (GTK4)

This project is a custom desktop shell configuration built using **Aylur's GTK Shell (AGS) v2**. It leverages GTK4, GJS, and TypeScript to create a modern, highly customizable desktop experience.

## Project Overview

- **Purpose:** Custom Linux desktop widgets (Bar, System Tray, Volume/Brightness controls, etc.).
- **Core Technology:** [AGS v2](https://github.com/Aylur/ags) (GTK4 branch).
- **Languages:** TypeScript (TSX), SCSS.
- **Architecture:** Component-based UI using JSX/TSX, with modular styling and helper utilities.

## Directory Structure

- `app.ts`: The main entry point. Configures the CSS and starts the initial windows.
- `widget/`: Contains the UI components (e.g., `Bar.tsx`, `Volume.tsx`, `Time.tsx`).
- `styles/`: Modular SCSS files for styling individual widgets.
- `helpers/`: Low-level system interaction scripts and utility functions.
- `main.scss`: The main stylesheet that imports all other modules.
- `@girs/`: Type definitions for GObject Introspection modules.

## Getting Started

### Prerequisites
- `ags` (version 2.x/GTK4)
- `gjs`
- `typescript`

### Key Commands
- **Run:** `ags run .` (Starts the shell from the current directory)
- **Quit:** `ags quit`
- **Inspector:** `ags inspector` (Opens the GTK debugger)
- **Type Check:** `tsc --noEmit` (Validate TypeScript without building)

## Development Conventions

- **Component Patterns:** Widgets are defined as functional components returning TSX.
- **Styling:** Modular SCSS is preferred. Use the `styles/` directory and import in `main.scss`.
- **Formatting:** 
  - Semi-colons: None (`semi: false`).
  - Indentation: 2 spaces (`tabWidth: 2`).
- **GObject Usage:** When interacting with system APIs, prefer using the wrappers in `helpers/` or standard AGS services.

## Important Files

- `app.ts`: Defines which windows are opened on startup.
- `widget/Bar.tsx`: The primary status bar layout and configuration.
- `main.scss`: Global styles and font definitions.
- `tsconfig.json`: Configured for `react-jsx` with `ags/gtk4` as the import source.

## User Preferences
- **Style:** Keep code clean and modular. Split big widgets into separate files.
- **Tools:** I use Neovim and pnpm.
- **Language:** Respond in Russian, but keep code comments and technical terms in English.

