<div align="center">

# Minneapolis Travel Guide 2026

### Open Source Summit + Embedded Linux Conference North America

**Speaker Travel Guidebook for KKamJi**

[![Kubernetes](https://img.shields.io/badge/Deploy-Kubernetes-326CE5?logo=kubernetes&logoColor=white)](values.yaml)
[![Helm](https://img.shields.io/badge/Chart-Helm_v3-0F1689?logo=helm&logoColor=white)](Chart.yaml)
[![HTML](https://img.shields.io/badge/Guide-HTML5-E34F26?logo=html5&logoColor=white)](files/index.html)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

`lf-oss-summit-2026.kkamji.net`

</div>

## About

LF Open Source Summit + ELC NA 2026 (Minneapolis, MN) 참석을 위한 개인 여행 가이드북입니다. 단일 HTML 파일 기반의 정적 웹사이트로, Helm Chart를 통해 Kubernetes 클러스터에 배포합니다.

## Preview

| Schedule | Transport | Explore |
|:---:|:---:|:---:|
| ![Schedule](https://img.shields.io/badge/일정-타임라인-c9a84c?style=flat-square) | ![Transport](https://img.shields.io/badge/교통·숙소-DoubleTree-c9a84c?style=flat-square) | ![Explore](https://img.shields.io/badge/관광-13_spots-c9a84c?style=flat-square) |

| Food | Tips |
|:---:|:---:|
| ![Food](https://img.shields.io/badge/맛집-한식·커피·심야-c9a84c?style=flat-square) | ![Tips](https://img.shields.io/badge/팁-안전·eSIM·패킹-c9a84c?style=flat-square) |

## Features

- **Tab Navigation** — Hero 고정 + 5탭 (일정 / 교통·숙소 / 관광 / 맛집 / 팁)
- **13 Attraction Detail Pages** — Deep Research 기반 관광지별 완전 가이드
- **Interactive Distance Cards** — DoubleTree 기준 도보/Uber 시간 + 클릭 시 상세 정보
- **Google Maps Integration** — 모든 관광지/맛집에 길찾기 링크
- **Photo Gallery** — Unsplash 기반 관광지/음식 이미지
- **Korean Traveler Focused** — 한식 맛집, 안전 정보, eSIM 가이드, 팁 문화, 패킹 리스트
- **Zero Dependencies** — 순수 HTML/CSS/JS, Google Fonts만 사용

## Trip Info

```
Event     Open Source Summit + ELC NA 2026
Dates     May 18-20, 2026
Venue     Minneapolis Convention Center
Hotel     DoubleTree Suites by Hilton Minneapolis Downtown
Speaker   TaeJi Kim (@KKamJi98)
Session   "Troubleshooting Like a Senior on Day 1:
           ReAct Agents with Real-Time Cluster Evidence"
Time      May 18 (Mon) 2:25 PM CDT, Room 101F
Track     Cloud + Orchestration / Open AI & Data
```

## Project Structure

```
.
├── Chart.yaml                  # Helm chart metadata
├── values.yaml                 # Helm values (image, ingress, resources)
├── templates/
│   ├── _helpers.tpl            # Template helpers
│   ├── configmap.yaml          # HTML → ConfigMap
│   ├── deployment.yaml         # nginx:alpine + volume mount
│   ├── service.yaml            # ClusterIP:80
│   ├── ingress.yaml            # TLS + external-dns
│   └── NOTES.txt               # Post-install notes
├── files/
│   ├── index.html              # Main guidebook (5 tabs)
│   └── attractions/            # 13 detail pages
│       ├── stone-arch-bridge.html
│       ├── sculpture-garden.html
│       ├── minnehaha-falls.html
│       ├── mill-ruins-park.html
│       ├── bde-maka-ska.html
│       ├── first-avenue.html
│       ├── guthrie-theater.html
│       ├── bob-dylan-mural.html
│       ├── boom-island-park.html
│       ├── mia.html
│       ├── foshay-deck.html
│       ├── mall-of-america.html
│       └── mill-city-museum.html
└── docs/
    └── superpowers/
        └── plans/              # Implementation plans
```

## Deployment

### Local Preview

```bash
python3 -m http.server 8080 --directory files/
# Open http://localhost:8080
```

### Kubernetes (Helm)

```bash
helm install lf-oss-2026 . \
  --namespace lf-oss-2026 \
  --create-namespace
```

### Ingress Configuration

| Annotation | Value |
|---|---|
| `cert-manager.io/cluster-issuer` | `letsencrypt-prod` |
| `external-dns.alpha.kubernetes.io/target` | `121.130.214.237` |
| `nginx.ingress.kubernetes.io/force-ssl-redirect` | `true` |
| **Host** | `lf-oss-summit-2026.kkamji.net` |

## Tech Stack

| Layer | Technology |
|---|---|
| Frontend | HTML5, CSS3 (Custom Properties), Vanilla JS |
| Fonts | Google Fonts (Playfair Display, DM Sans, DM Mono) |
| Images | Unsplash (free license) |
| Container | nginx:alpine |
| Orchestration | Kubernetes + Helm v3 |
| TLS | cert-manager + Let's Encrypt |
| DNS | external-dns |
| Ingress | nginx-ingress-controller |

## Content Sources

- **Attraction Data** — Deep Research via multi-agent system (Playwright-verified)
- **Distance/Time** — DoubleTree Suites by Hilton (1101 LaSalle Ave) baseline
- **Restaurant Data** — Yelp, Google Maps, local Minneapolis food blogs
- **Safety Info** — Minneapolis PD community resources, Korean consulate
- **Weather Data** — NOAA historical averages for May in Minneapolis

---

<div align="center">

**Minneapolis, Minnesota**

*May 2026*

Built with [Claude Code](https://claude.ai/code)

</div>
