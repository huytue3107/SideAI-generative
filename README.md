# SideAI

SideAI là studio AI mã nguồn mở để tạo ảnh, video, lip sync, cảnh điện ảnh và workflow tự động. Dự án dùng Next.js cho bản web, Electron/Vite cho bản desktop và tích hợp Muapi để truy cập nhiều mô hình tạo sinh.

## Tính năng chính

- **Image Studio**: tạo ảnh từ prompt hoặc chỉnh sửa ảnh tham chiếu.
- **Video Studio**: tạo video từ prompt hoặc animate ảnh đầu vào.
- **Lip Sync Studio**: đồng bộ môi cho ảnh chân dung hoặc video bằng audio.
- **Cinema Studio**: tạo khung hình điện ảnh với các tuỳ chọn camera.
- **Workflow Studio**: xây dựng pipeline nhiều bước bằng giao diện node.
- **Agent Studio**: giao diện chat/agent dùng API Muapi.
- **Local Inference**: chạy một số mô hình cục bộ qua `sd.cpp` trong desktop app.
- **Wan2GP Server**: kết nối server Wan2GP riêng cho một số workflow ảnh/video nặng.

## Yêu cầu môi trường

- Node.js 20 trở lên.
- npm đi kèm Node.js.
- Git.
- API key Muapi nếu dùng các mô hình cloud.
- Desktop local inference cần máy phù hợp với engine bạn chọn:
  - `sd.cpp`: CPU, Apple Silicon Metal, CUDA, Vulkan hoặc ROCm tuỳ nền tảng.
  - Wan2GP: server Python/PyTorch riêng, thường cần GPU NVIDIA hoặc AMD.

Trên Windows, nếu PowerShell chặn `npm.ps1`, hãy dùng `npm.cmd`:

```powershell
npm.cmd run dev
```

## Cài đặt từ source

```bash
git clone --recurse-submodules https://github.com/huytue3107/SideAI-generative.git
cd SideAI-generative
npm install
npm run build:packages
```

Chạy web app ở môi trường dev:

```bash
npm run dev
```

Mở:

```text
http://localhost:3000
```

Build production:

```bash
npm run build
npm run start
```

## Chạy desktop app

Build giao diện Vite và mở Electron:

```bash
npm run electron:dev
```

Build installer theo hệ điều hành:

```bash
npm run electron:build:win
npm run electron:build:linux
npm run electron:build
```

File build được xuất vào thư mục `release/`.

## Local inference

SideAI desktop hỗ trợ local inference qua `sd.cpp`.

Trong app:

1. Mở **Settings**.
2. Vào **Local Models**.
3. Cài engine `sd.cpp`.
4. Tải model bạn muốn dùng.
5. Vào **Image Studio** và bật chế độ **Local**.

Binary macOS Apple Silicon được lưu trong repo này tại:

```text
binaries/sd-cli-metal-macos-arm64.zip
```

Code tải binary từ:

```text
https://raw.githubusercontent.com/huytue3107/SideAI-generative/main/binaries/sd-cli-metal-macos-arm64.zip
```

Các nền tảng khác dùng release upstream của `stable-diffusion.cpp` khi cần.

## Wan2GP server

SideAI không đóng gói Wan2GP. Bạn cần chạy server riêng trên máy GPU rồi nhập URL server trong **Settings > Local Models > Wan2GP server**.

Ví dụ trên máy GPU:

```bash
git clone https://github.com/deepbeepmeep/Wan2GP
cd Wan2GP
./install.sh
python wgp.py --listen --server-name 0.0.0.0
```

Sau đó nhập URL dạng:

```text
http://192.168.1.42:7860
```

## Cấu trúc dự án

```text
SideAI-generative/
  app/                         Next.js App Router
  components/                  Component dùng cho web app
  src/                         Shell desktop/Vite
  electron/                    Main process và IPC Electron
  packages/studio/             Studio component package
  packages/sideai-workflow/    Workflow builder package
  packages/sideai-agents/      Agent package
  binaries/                    Binary tùy chỉnh cho local inference
  public/                      Asset tĩnh
  build/                       Cấu hình installer
```

## Script thường dùng

| Lệnh | Mục đích |
|---|---|
| `npm run dev` | Chạy web app dev |
| `npm run build` | Build Next.js production |
| `npm run start` | Chạy production server |
| `npm run build:packages` | Build các workspace package |
| `npm run vite:dev` | Chạy Vite shell |
| `npm run electron:dev` | Chạy desktop app dev |
| `npm run electron:build:win` | Build installer Windows |
| `npm run electron:build:linux` | Build installer Linux |

## Ghi chú bảo mật

- API key được lưu ở client để gọi Muapi.
- Không commit API key, token hoặc credential cá nhân.
- File binary trong `binaries/` là asset dùng để app tải local inference engine.

## Kiểm tra nhanh

```bash
npm install
npm run build:packages
npm run build
```

Nếu cả ba lệnh chạy thành công, source hiện tại đủ điều kiện để chạy bản web production.
