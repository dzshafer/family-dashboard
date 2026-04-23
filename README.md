# 🏠 Family Dashboard

A soft, pastel family calendar + kids daily task tracker.  
Built for wall-mounted displays, Raspberry Pi, or Android kitchen screens.

---

## Features

- **Calendar pane** — fetches your public Google Calendar via ICS URL
  - Today + Tomorrow view (default)
  - Week view
  - Month view
- **Kids task pane** — 3 customizable kids with daily to-do lists
  - Repeatable daily tasks (auto-reset at midnight)
  - Add/remove tasks anytime
  - Progress bar + completion celebration
  - Color-coded per kid
- **Portrait & Landscape** — auto-adapts layout via CSS
- **PWA-ready** — installable on Android as a home screen app

---

## Quick Start (Raspberry Pi)

### 1. Install Docker

```bash
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER
# Log out and back in
```

### 2. Clone or copy this project

```bash
git clone https://github.com/YOUR-USERNAME/family-dashboard.git
cd family-dashboard
```

### 3. Build & run

```bash
docker compose up -d --build
```

Dashboard is now at: **http://YOUR-PI-IP:3030**

---

## Google Calendar Setup

1. Open Google Calendar on desktop
2. Click the ⚙️ gear → **Settings**
3. Select your calendar from the left sidebar
4. Scroll down to **"Integrate calendar"**
5. Copy the **"Public address in iCal format"** (starts with `webcal://` or `https://`)
6. In the dashboard, click the ⚙️ icon → paste the URL → Save

> Your calendar must be set to **Public** for this to work.

---

## Customizing Kids

Click the ⚙️ settings icon in the dashboard:
- Change kid names
- Pick a color for each kid
- Add/remove tasks directly on the cards

Task completion resets **automatically at midnight** each day.

---

## Android Kitchen Display / Tablet

### Option A — Browser Kiosk (easiest)
1. Connect the Android device to the same WiFi as your Pi
2. Open Chrome → go to `http://YOUR-PI-IP:3030`
3. Tap the browser menu → **"Add to Home Screen"**
4. Open the installed app — it runs fullscreen

### Option B — Chrome Kiosk Mode (Android TV/display sticks)
Install **Kiosk Browser** from the Play Store, set URL to `http://YOUR-PI-IP:3030`

### Option C — Pi Zero W (headless, display via HDMI)
```bash
# On Pi OS Desktop, auto-launch Chromium in kiosk mode on boot
# Edit /etc/xdg/lxsession/LXDE-pi/autostart:

@chromium-browser --kiosk --noerrdialogs --disable-infobars \
  --disable-session-crashed-bubble \
  http://localhost:3030
```

---

## Raspberry Pi Zero Notes

Pi Zero W runs Docker but slowly — image build may take a few minutes.  
For fastest performance on Pi Zero:

```bash
# Run without Docker using Python's built-in server:
cd family-dashboard
python3 -m http.server 3030
```

Then set it to launch on boot via `rc.local` or a systemd unit.

---

## Auto-Update Calendar

The dashboard has a manual "↻ Refresh" button. For fully automatic refresh,  
add this to your Pi's crontab to reload Chromium every hour:

```bash
# crontab -e
0 * * * * DISPLAY=:0 chromium-browser --kiosk http://localhost:3030 &>/dev/null
```

Or simply open Settings → the calendar re-fetches on save.

---

## File Structure

```
family-dashboard/
├── index.html          # The entire app (single file!)
├── manifest.json       # PWA manifest for Android install
├── nginx.conf          # Nginx serving config
├── Dockerfile          # Container build
├── docker-compose.yml  # Easy deploy
└── README.md
```

---

## Ports

| Port | Service |
|------|---------|
| 3030 | Dashboard (change in docker-compose.yml if needed) |

---

## Tech Stack

- Pure HTML/CSS/JS — no build tools, no Node, no frameworks
- ICS calendar parsing done client-side
- localStorage for task persistence
- Served by nginx:alpine (~25MB image)
