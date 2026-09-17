# Amaliy mashgʻulot 1. Koʻp tugunli konteyner muhitini qurish va oʻlchash

**Fan:** Taqsimlangan tizimlar · **Bogʻliq maʼruza:** M1–M2 · **Ajratilgan vaqt:** 2 soat · **Ball:** 3

---

## 0. Ishni boshlash

1. Shu sahifada yashil **Use this template** → **Create a new repository** tugmasini bosing.
2. Repozitoriy nomini `dt-a1-familiyangiz` koʻrinishida qoʻying, **Public** tanlang, **Create** bosing.
3. Oʻz repozitoriyingizda **Code** → **Codespaces** → **Create codespace on main**.
4. 1–2 daqiqa kuting. Brauzerda VS Code ochiladi.
5. Terminalni oching (``Ctrl+` ``) va tekshiring:

```bash
docker --version
docker compose version
```

Ikkala buyruq ham versiya raqamini qaytarishi kerak. Agar `Cannot connect to the Docker daemon` chiqsa, 30 soniya kutib qayta urinib koʻring — muhit hali toʻliq yuklanmagan.

---

## 1. Tugunlarni koʻtarish

```bash
docker compose up -d --build
docker compose ps
```

`docker compose ps` natijasida uchta tugun `running` holatida boʻlishi kerak. **Ekran nusxasini oling** — hisobotga kerak boʻladi.

---

## 2. Aloqani tekshirish

```bash
curl http://localhost:8081/salom
curl http://localhost:8081/chaqir/tugun2
curl http://localhost:8082/chaqir/tugun3

# Compose ichidagi DNS yechimini tekshirish:
docker compose exec tugun1 getent hosts tugun2
```

Oxirgi buyruq `tugun2` ning IP manzilini koʻrsatadi. **Diqqat:** siz hech qayerda bu IP ni yozmadingiz — Compose uni avtomatik yaratdi. Bu maʼruzadagi *joylashuv shaffofligi*ning amaliy koʻrinishi.

Barcha yoʻnalishlarni bir vaqtda tekshirish uchun:

```bash
bash matritsa.sh 3
```

---

## 3. Kechikishni oʻlchash

Bitta yoʻnalish:

```bash
bash olcha.sh 8081 tugun2 100
```

Barcha yoʻnalishlar (hisobot jadvali uchun):

```bash
bash olcha-hammasi.sh 3 100
```

Natijani faylga yozib oling:

```bash
bash olcha-hammasi.sh 3 100 | tee natijalar/olchov-1-asosiy.txt
```

---

## 4. Nosozlikni modellashtirish

Har bir holatda **javob matnini ham, javob vaqtini ham** qayd eting:

```bash
# a) Tugun butunlay oʻchirilgan
docker compose stop tugun2
time curl http://localhost:8081/chaqir/tugun2
docker compose start tugun2

# b) Tugun muzlatilgan (jarayon toʻxtatilgan, lekin port ochiq)
docker compose pause tugun3
time curl http://localhost:8081/chaqir/tugun3
docker compose unpause tugun3

# c) Mavjud boʻlmagan tugun nomi
time curl http://localhost:8081/chaqir/tugun9
```

**(a) va (b) orasidagi farqni tushunish shu ishning asosiy maqsadi.** Oʻchirilgan tugunda xatolik darhol qaytadi, muzlatilgan tugunda esa soʻrov timeout gacha kutadi. Mijoz uchun ikkinchisi ancha xavfli — chunki u "oʻlik" va "sekin" tugunni ajrata olmaydi.

---

## 5. Mustaqil topshiriq

Variantingizni oʻqituvchidan oling (variantlar jadvali quyida).

### 5.1. Besh tugunga kengaytirish

```bash
docker compose down
docker compose -f compose-5.yaml up -d --build
bash matritsa.sh 5
```

### 5.2. Har bir yoʻnalish uchun 200 tadan soʻrov

```bash
bash olcha-hammasi.sh 5 200 | tee natijalar/olchov-2-besh-tugun.txt
```

### 5.3. Sunʼiy kechikish

`compose-5.yaml` faylida har bir tugunning `KECHIKISH_MS` qiymatini variantingizdagi songa oʻzgartiring, soʻng:

```bash
docker compose -f compose-5.yaml up -d
bash olcha-hammasi.sh 5 200 | tee natijalar/olchov-3-kechikish.txt
```

Savolga javob bering: p50 qanday oʻzgardi, p99 qanday oʻzgardi? Nega bir xil emas?

### 5.4. Resurs cheklovi

`compose-5.yaml` dagi `tugun5` ning `deploy.resources` blokidagi izohlarni oching, soʻng:

```bash
docker compose -f compose-5.yaml up -d
bash olcha.sh 8085 tugun1 200 | tee natijalar/olchov-4-cpu.txt
```

### 5.5. Uch xil nosozlik

```bash
docker compose -f compose-5.yaml stop tugun2     # oʻchirilgan
docker compose -f compose-5.yaml pause tugun3    # muzlatilgan
# tugun4 uchun compose-5.yaml da portni 8084:9999 ga oʻzgartiring — notoʻgʻri port
bash matritsa.sh 5
```

---

## Variantlar

| Variant | Tugunlar soni | Sunʼiy kechikish | Qoʻshimcha shart |
|---|---|---|---|
| 1 | 5 | 50 ms | CPU cheklovi 0.2 |
| 2 | 5 | 100 ms | Xotira cheklovi 64 MB |
| 3 | 7 | 25 ms | Tasodifiy kechikish 0–100 ms |
| 4 | 7 | 75 ms | Har 10-soʻrovda xatolik qaytarish |

---

## Topshirish

1. `hisobot.md` faylini toʻldiring.
2. Ekran nusxalarini `natijalar/` katalogiga joylang.
3. Ishni saqlang:

```bash
git add .
git commit -m "Amaliy 1 bajarildi"
git push
```

4. Oʻqituvchiga repozitoriyingiz havolasini yuboring.

---

## Ishni tugatgach

Pastki chap burchakdagi **Codespaces** menyusi → **Stop Current Codespace**.

Buni unutmang: toʻxtatilmagan codespace bepul soatlaringizni sarflab turadi.

---

## Tez-tez uchraydigan xatolar

| Xato | Sababi | Yechimi |
|---|---|---|
| `Cannot connect to the Docker daemon` | Codespace hali yuklanmagan | 30 soniya kutib qayta urinib koʻring |
| `port is already allocated` | Oldingi konteynerlar ishlayapti | `docker compose down` |
| `curl: command not found` | Notoʻgʻri terminal | VS Code terminalidan foydalaning |
| Oʻlchov 0.0000 chiqadi | Tugun koʻtarilmagan | `docker compose ps` bilan tekshiring |
| `permission denied: olcha.sh` | Fayl bajariladigan emas | `chmod +x *.sh` |
