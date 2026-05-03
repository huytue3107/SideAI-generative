# SideAI: Technical Documentation & Context

This document tracks the technical context for SideAI.

## Project Summary

SideAI is an AI image, video, lip sync, cinema, workflow, and agent studio. It combines a Next.js web app, an Electron desktop shell, Muapi cloud APIs, local `sd.cpp` inference, and optional Wan2GP server integration.

## Repository

- Repository: `https://github.com/huytue3107/SideAI-generative`
- Package name: `sideai`
- Electron product name: `SideAI`
- Electron app id: `ai.sideai.app`

## Architecture

- `app/`: Next.js App Router pages, API proxies, and metadata.
- `components/`: shared React components for the web app.
- `src/`: Vite desktop shell entrypoints and vanilla DOM studio placeholders.
- `electron/`: Electron main process, IPC handlers, local inference, and Wan2GP provider.
- `packages/studio/`: reusable studio package.
- `packages/sideai-workflow/`: workflow builder package.
- `packages/sideai-agents/`: agent package.
- `binaries/`: SideAI-hosted binary assets used by local inference downloads.

## Local Inference

SideAI uses `electron/lib/localInference.js` for local `sd.cpp` engine management. The macOS Apple Silicon custom binary is hosted inside this repository and downloaded from:

```text
https://raw.githubusercontent.com/huytue3107/SideAI-generative/main/binaries/sd-cli-metal-macos-arm64.zip
```

Other platforms fall back to compatible `stable-diffusion.cpp` release assets.

## Development Commands

```bash
npm install
npm run build:packages
npm run dev
npm run build
npm run electron:dev
```

On Windows PowerShell, use `npm.cmd` if execution policy blocks `npm.ps1`.
