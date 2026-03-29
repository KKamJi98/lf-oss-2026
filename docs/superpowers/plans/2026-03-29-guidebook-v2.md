# Minneapolis Guidebook v2 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Rebuild the Minneapolis travel guidebook with tab navigation, larger fonts, enriched content (safety, Korean food, eSIM, packing list, etc.), and Playwright verification.

**Architecture:** Single HTML file with vanilla CSS/JS. Hero section fixed at top, 5 tabs below (일정, 교통·숙소, 관광, 맛집, 팁). Tab switching via JS class toggling. Accordion pattern for clickable distance details on attraction cards.

**Tech Stack:** HTML5, CSS3 (custom properties), vanilla JavaScript, Playwright (verification)

---

### Task 1: Complete HTML Rewrite — Core Structure + CSS + Hero

**Files:**
- Rewrite: `files/index.html`

- [ ] **Step 1: Write complete HTML with all sections**

Rewrite `files/index.html` with:

**CSS changes (readability):**
- body font-size: 14px → 16px
- card-body: 13px → 15px
- card-name: 17px → 20px
- timeline-body: 14px → 16px
- info-table td: 14px → 16px
- section max-width: 900px → 1000px

**Layout structure:**
```
<nav> — fixed top, tab links
<div class="hero"> — always visible, compact (not full-height)
  - "Open Source Summit + Embedded Linux Conference North America 2026"
  - Minneapolis / Minnesota
  - 출발 5.17 | 행사 5.18-20 | 귀국 5.22
</div>
<div class="tab-bar"> — sticky below hero
  일정 | 교통·숙소 | 관광 | 맛집 | 팁
</div>
<div class="tab-content">
  <section id="tab-schedule"> ... </section>
  <section id="tab-transport"> ... </section>
  <section id="tab-explore"> ... </section>
  <section id="tab-food"> ... </section>
  <section id="tab-tips"> ... </section>
</div>
<footer>
```

**Hero changes:**
- hero min-height: 100vh → auto (compact, not full screen)
- hero-tag: "Open Source Summit + Embedded Linux Conference North America 2026"
- Remove confirmation number from ALL sections

**Tab system JS:**
```javascript
document.querySelectorAll('.tab-btn').forEach(btn => {
  btn.addEventListener('click', () => {
    document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
    document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));
    btn.classList.add('active');
    document.getElementById(btn.dataset.tab).classList.add('active');
  });
});
```

**Accordion JS for distance details:**
```javascript
document.querySelectorAll('.distance-toggle').forEach(toggle => {
  toggle.addEventListener('click', () => {
    const detail = toggle.nextElementSibling;
    detail.classList.toggle('open');
    toggle.classList.toggle('open');
  });
});
```

- [ ] **Step 2: Serve and visually verify in browser**

Run: `python3 -m http.server 8080 --directory files/`
Open: http://localhost:8080
Check: Hero renders, tabs switch, font sizes readable

- [ ] **Step 3: Commit**

```bash
git add files/index.html
git commit -m "feat: rebuild guidebook v2 with tab navigation and enriched content"
```

---

### Task 2: 일정 Tab Content

**Content to include in the 일정 tab:**

- Timeline with CORRECTED dates:
  - 5/17 (토) — 인천 출발, Delta 직항
  - 5/18 (월) — 행사 첫날, **발표: 2:25 PM CDT, Room 101F**
  - 5/19 (화) — 행사 2일차
  - 5/20 (수) — 행사 마지막 날
  - 5/21 (목) — 자유 여행
  - 5/22 (금) — Mall of America → 귀국

- Art-A-Whirl 이벤트 highlight box:
  - 5/15~17 무료 아트 이벤트
  - 도착일(5/17) 겹침 — 오후 늦게 참여 가능

- Slide submission 마감: 5/17 (일) 현지 자정

---

### Task 3: 교통·숙소 Tab Content

**교통 section:**
- 항공: Delta 직항 (A350-900), 비행시간 12h30m~14h
- Blue Line: 러시아워 $2.50 / 비러시 $2.00 / 다운타운 $0.50, 벌금 $180+
- Uber/Lyft: 공항→다운타운 $30~40 (피크 $40~50), Terminal Level 2 픽업
- Skyway: 15km/80블록, 운영시간 요일별, 앱 skyway.run

**숙소 section:**
- DoubleTree Suites by Hilton — 확정 카드 (강조 스타일):
  - 1101 LaSalle Ave
  - 컨벤션센터 도보 8~10분
  - 전 객실 Suite (거실+침실 분리)
  - Hilton Honors 포인트, 무료 Wi-Fi
- 대안 호텔: Sheraton (도보 2분), Holiday Inn Express (조식 포함), Hilton (수영장)

---

### Task 4: 관광 Tab Content

**각 카드에 distance-toggle 포함:**
```html
<div class="distance-toggle">
  <span class="badge-walk">도보 25분</span>
  <span class="badge-uber">우버 8분</span>
</div>
<div class="distance-detail">
  Uber 예상 $10~12 | 추천 시간: 일몰 1시간 전 (20:00경)
  Stone Arch Bridge 위에서 다운타운 스카이라인 + 세인트앤서니폭포 촬영
</div>
```

**관광지 목록 (DoubleTree 기준 거리):**

무료:
- Stone Arch Bridge — 도보 25~30분 / Uber 8분/$10~12
- Minneapolis Sculpture Garden — 도보 15~20분 / Uber 6분/$8~10
- Minnehaha Falls — Uber 15분/$15~20
- Mill Ruins Park — 도보 25~30분 / Uber 8분/$10~12
- Bde Maka Ska — Uber 12분/$12~15
- First Avenue — 도보 10~12분 / Uber 4분/$8
- Guthrie Theater Amber Box — 도보 25분 / Uber 8분/$10~12
- Bob Dylan Mural — 도보 10분
- Boom Island Park — Uber 10분

유료:
- Minneapolis Institute of Art — 도보 20~25분 / Uber 8분/$10~12 (무료 입장)
- Foshay Observation Deck — 도보 5~7분 / $18
- Mall of America — Blue Line 25~30분 / Uber 20분/$25~30
- Mill City Museum — 도보 25~30분 / Uber 8분/$10~12

포토스팟 Top 5 highlight box

---

### Task 5: 맛집 Tab Content

**카테고리별 카드 그리드:**

한식/아시안:
- Hoban Korean BBQ — Uber 12분
- Korea Restaurant — Uber 10분
- MINARI & The Pikok Lounge — Uber 12분
- Kimchi Tofu House — Uber 10분
- Bonchon — Uber 12분
- H Mart (식료품) — Uber 10분

컨벤션센터 근처 (도보 5~15분):
- Spoon and Stable — 파인다이닝, 예약 필수
- Devil's Advocate — Juicy Lucy 버거
- Klassics Kitchen — 칵테일 + 브런치
- The Nicollet Diner — 24시간
- Pizza Luce — 새벽 1시+

커피숍:
- Spyhouse Coffee — 스페셜티, 노트북 작업
- Gray Fox Coffee — Skyway 내
- FRGMNT Coffee — Skyway 내

심야 음식 highlight box:
- 24시간: Nicollet Diner
- 새벽 1시+: Pizza Luce
- 새벽 2:30: Nightingale

---

### Task 6: 팁 Tab Content

**안전 정보 (highlight box, 중요):**
- 다운타운 낮 안전, 밤 주의
- 피해야 할 지역: North Minneapolis, Phillips/Ventura Village
- 야간 수칙: 밤 10시 이후 Uber 활용, Blue Line 앞칸 탑승
- 긴급: 911, 영사 콜센터 +82-2-3210-0404

**팁 문화:**
- 레스토랑 18~20% (Hospitality Charge 자동 부과 시 추가 팁 불필요)
- 카운터/카페 0~15%
- Uber/Lyft 10~15%
- 호텔 하우스키핑 $2~5

**데이터/통신:**
- eSIM: Airalo 7일 5GB $10~15
- 한국 로밍: 일 ₩11,000~14,000
- Wi-Fi: 컨벤션센터 무료, DoubleTree 무료 (Honors)

**전원:**
- 120V/60Hz, A/B 타입
- 돼지코 어댑터 2개 필수
- 노트북/폰 충전기는 100~240V 자동변환

**날씨/패킹:**
- 낮 19~21°C / 밤 9~11°C / 비 37% 확률
- 일출 05:45 / 일몰 20:40
- 필수: 경량 패딩, 가디건, 우산, 어댑터 2개, 선크림
- 컨퍼런스: 비즈캐주얼 1~2벌, 프레젠터 리모컨

**앱 추천:**
- Metro Transit, skyway.run, Uber/Lyft, Sched (osselcna2026.sched.com)

확인번호(Y8NGJ9J7PKY) — 웹에서 완전 제거

---

### Task 7: Playwright Verification

**Files:**
- Create: `tests/guidebook.spec.js`

- [ ] **Step 1: Install Playwright**

Run: `npm init -y && npm install -D @playwright/test && npx playwright install chromium`

- [ ] **Step 2: Write verification tests**

```javascript
import { test, expect } from '@playwright/test';

test.describe('Guidebook v2', () => {
  test.beforeEach(async ({ page }) => {
    await page.goto('http://localhost:8080');
  });

  test('hero shows correct event title', async ({ page }) => {
    await expect(page.locator('.hero')).toContainText('Open Source Summit');
    await expect(page.locator('.hero')).toContainText('Embedded Linux Conference');
  });

  test('no confirmation number visible', async ({ page }) => {
    await expect(page.locator('body')).not.toContainText('Y8NGJ9J7PKY');
  });

  test('5 tabs exist and switch correctly', async ({ page }) => {
    const tabs = page.locator('.tab-btn');
    await expect(tabs).toHaveCount(5);
    for (let i = 0; i < 5; i++) {
      await tabs.nth(i).click();
      await expect(tabs.nth(i)).toHaveClass(/active/);
    }
  });

  test('font sizes meet minimum', async ({ page }) => {
    const bodyFontSize = await page.locator('body').evaluate(
      el => getComputedStyle(el).fontSize
    );
    expect(parseInt(bodyFontSize)).toBeGreaterThanOrEqual(16);
  });

  test('DoubleTree is marked as confirmed hotel', async ({ page }) => {
    await page.locator('[data-tab="tab-transport"]').click();
    await expect(page.locator('.hotel-confirmed')).toContainText('DoubleTree');
  });

  test('distance badges are clickable', async ({ page }) => {
    await page.locator('[data-tab="tab-explore"]').click();
    const toggle = page.locator('.distance-toggle').first();
    await toggle.click();
    await expect(toggle.locator('+ .distance-detail')).toBeVisible();
  });

  test('correct date for May 18 is Monday', async ({ page }) => {
    await page.locator('[data-tab="tab-schedule"]').click();
    await expect(page.locator('#tab-schedule')).toContainText('5월 18일 (월)');
    await expect(page.locator('#tab-schedule')).not.toContainText('5월 18일 (일)');
  });

  test('presentation time and room shown', async ({ page }) => {
    await page.locator('[data-tab="tab-schedule"]').click();
    await expect(page.locator('#tab-schedule')).toContainText('2:25 PM');
    await expect(page.locator('#tab-schedule')).toContainText('Room 101F');
  });
});
```

- [ ] **Step 3: Run tests**

Run: `npx playwright test tests/guidebook.spec.js --reporter=list`
Expected: All 8 tests PASS

- [ ] **Step 4: Fix any failures and re-run**

- [ ] **Step 5: Take screenshot for visual review**

```javascript
// Add to test file
test('screenshot for visual review', async ({ page }) => {
  await page.screenshot({ path: 'tests/screenshots/hero.png', fullPage: false });
  for (const tab of ['schedule', 'transport', 'explore', 'food', 'tips']) {
    await page.locator(`[data-tab="tab-${tab}"]`).click();
    await page.screenshot({ path: `tests/screenshots/tab-${tab}.png`, fullPage: true });
  }
});
```

- [ ] **Step 6: Commit**

```bash
git add tests/ package.json package-lock.json
git commit -m "test: add Playwright verification for guidebook v2"
```
