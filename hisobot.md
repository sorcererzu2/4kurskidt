# Amaliy mashgʻulot 1 — Hisobot

**Talaba:** ______________________  **Guruh:** __________  **Variant:** ____  **Sana:** __________

---

## 1. Ishning maqsadi va bajarilgan bosqichlar

_(3–5 jumla: nima qilindi, qanday muhitda)_

---

## 2. Fayllar

Kod fayllari shu repozitoriyda: `app.py`, `Dockerfile`, `compose.yaml`, `compose-5.yaml`.

Kiritilgan oʻzgarishlar:

_(Masalan: KECHIKISH_MS qiymati 50 ms qilindi; tugun5 ga CPU cheklovi qoʻyildi)_

---

## 3. Muhit holati

`docker compose ps` natijasi:

![compose ps](natijalar/compose-ps.png)

---

## 4. Kechikish oʻlchovlari (asosiy holat)

| Yoʻnalish | n | p50 (ms) | p95 (ms) | p99 (ms) | max (ms) |
|---|---|---|---|---|---|
| tugun1 → tugun2 | 200 | | | | |
| tugun1 → tugun3 | 200 | | | | |
| tugun2 → tugun1 | 200 | | | | |
| tugun2 → tugun3 | 200 | | | | |
| tugun3 → tugun1 | 200 | | | | |
| tugun3 → tugun2 | 200 | | | | |

_(Skript soniyada qaytaradi — 1000 ga koʻpaytirib millisekundga oʻtkazing)_

---

## 5. Sunʼiy kechikish va resurs cheklovi

### 5.1. Sunʼiy kechikish qoʻshilgandan keyin

| Holat | p50 (ms) | p95 (ms) | p99 (ms) |
|---|---|---|---|
| Kechikishsiz | | | |
| KECHIKISH_MS = ____ | | | |
| **Farq** | | | |

**Tahlil:** _(p50 va p99 bir xil oʻzgardimi? Nega?)_

### 5.2. CPU cheklovi qoʻyilgandan keyin

| Holat | p50 (ms) | p95 (ms) | p99 (ms) |
|---|---|---|---|
| Cheklovsiz | | | |
| cpus = 0.2 | | | |

**Tahlil:** _(Qaysi koʻrsatkich koʻproq oʻzgardi? Nega aynan u?)_

---

## 6. Nosozlik holatlari

| Holat | Buyruq | Qaytgan xatolik | Javob vaqti |
|---|---|---|---|
| Tugun oʻchirilgan | `docker compose stop` | | |
| Tugun muzlatilgan | `docker compose pause` | | |
| Notoʻgʻri port / nom | — | | |

**Tahlil:** _(Uch holatning mijoz uchun farqi nimada? Qaysi biri eng xavfli va nega?)_

---

## 7. Xulosa

_(Kamida 5–7 jumla. Quyidagilarga javob bering:)_

- Mahalliy funksiya chaqiruvi va tarmoq chaqiruvi orasidagi farqni oʻz oʻlchovlaringiz qanday koʻrsatdi?
- Nima uchun oʻrtacha qiymat emas, foizli qiymatlar ishlatiladi?
- Timeout qoʻyilmagan chaqiruv qanday xavf tugʻdiradi?
- "Oʻlik tugun" va "sekin tugun" ni mijoz ajrata oladimi? Oʻlchovlaringiz nimani koʻrsatdi?

---

## 8. Nazorat savollariga javoblar

1. Docker Compose konteynerlar orasidagi nom yechimini qanday taʼminlaydi?
2. Konteyner va virtual mashinaning farqi nimada?
3. Kechikish va oʻtkazuvchanlik tushunchalarini farqlang.
4. Nima uchun foizli qiymatlar afzal?
5. Xizmat oʻchirilganda va sekinlashganda xatolik qanday farq qiladi?
6. Timeout qoʻyilmagan chaqiruv qanday xavf tugʻdiradi?
7. Oʻlchovlaringiz "kechikish nolga teng" taxminini qanday rad etadi?
8. Resurs cheklovi qoʻyilganda foizli qiymatlar nega oʻzgardi?
