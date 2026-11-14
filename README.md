# MTC Bus ITS Portal – 15-Minute Health Monitor

Automated headless monitoring of [https://mtcbusits.in/](https://mtcbusits.in/) via GitHub Actions (zero-cost, every 15 minutes).  
Sends push alerts to your phone via [ntfy.sh](https://ntfy.sh/) when thresholds are breached.

---

## 📋 What It Monitors

| Check | Metric | Alert Threshold |
|---|---|---|
| PIS Display Connectivity | 2L PIS Down count | > 20 |
| PIS Display Connectivity | 4L PIS Down count | > 6 |
| PIS Display Connectivity | 10L PIS Down count | > 3 |
| Fleet Dashboard | Communicating fleet count | < 2500 |

---

## ⚙️ One-Time Setup

### Step 1 — Add GitHub Repository Secrets

Go to your GitHub repository → **Settings** → **Secrets and variables** → **Actions** → **New repository secret**.

Add these **3 secrets** (names must be exact):

| Secret Name | Value |
|---|---|
| `MTC_USERNAME` | Your MTC portal login ID |
| `MTC_PASSWORD` | Your MTC portal password |
| `NTFY_TOPIC` | Your secret ntfy.sh topic name (e.g. `my-mtc-alerts-xk29`) |

> **Never** commit credentials to this repository. All sensitive values are loaded exclusively from the secrets above.

---

### Step 2 — Publish to GitHub (using VS Code GitHub Extension)

1. Open this folder in VS Code.
2. Open the **Source Control** panel (`Ctrl+Shift+G`).
3. Click **Publish to GitHub** (or use the command palette: `Publish to GitHub`).
4. Choose **Public repository**.
5. The GitHub Actions workflow will automatically activate.

---

### Step 3 — Install ntfy.sh on Your Phone

1. Install the **ntfy** app (Android / iOS).
2. Subscribe to the topic name you set as `NTFY_TOPIC`.
3. You will receive urgent push alerts whenever a threshold is breached.

---

## 🔧 Editing Alert Thresholds

All thresholds are stored in [`config.json`](config.json) — no Python code changes needed:

```json
{
  "pis_display_max_down": {
    "2L": 20,
    "4L": 6,
    "10L": 3
  },
  "fleet_dashboard_min_communicating": 2500,
  "timezone": "Asia/Kolkata"
}
```

After editing, commit and push the file. The next scheduled run will use the new values.

---

## ▶️ Manual Trigger

Go to your repository → **Actions** → **MTC Portal Health Monitor** → **Run workflow**.

---

## 🗂️ Repository Structure

```
mtc-monitor/
├── monitor.py                        # Main monitoring script
├── config.json                       # Alert thresholds (edit freely)
├── requirements.txt                  # Python dependencies
├── .gitignore                        # Excludes secrets, logs, screenshots
├── README.md                         # This file
└── .github/
    └── workflows/
        └── mtc_monitor.yml           # GitHub Actions schedule (every 15 min)
```

---

## 🔍 Troubleshooting

- **Login failures**: If CAPTCHA solving repeatedly fails after all 12 retries, an alert is sent and a `debug_failure.png` screenshot is uploaded as a GitHub Actions artifact.
- **Download artifact**: Go to the failed Actions run → scroll to **Artifacts** → download `debug-screenshot`.
- **Adjust retry logic**: The script attempts CAPTCHA solving up to 12 times before raising an error.

