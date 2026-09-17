#!/usr/bin/env bash
# olcha.sh — bitta yoʻnalish boʻyicha kechikishni oʻlchaydi.
# Ishlatilishi:  bash olcha.sh 8081 tugun2 100
#   $1 — manba tugunning tashqi porti
#   $2 — maqsad tugun nomi
#   $3 — soʻrovlar soni (sukut boʻyicha 100)

PORT=${1:-8081}
HEDEF=${2:-tugun2}
SON=${3:-100}

for i in $(seq 1 "$SON"); do
  curl -s -o /dev/null -w "%{time_total}\n" "http://localhost:${PORT}/chaqir/${HEDEF}"
done | sort -n | awk -v p="$PORT" -v h="$HEDEF" -v n="$SON" '{a[NR]=$1}
  END {
    printf "%s -> %-7s (n=%d)  p50=%.4f  p95=%.4f  p99=%.4f  max=%.4f\n",
      p, h, n, a[int(NR*0.50)], a[int(NR*0.95)], a[int(NR*0.99)], a[NR]
  }'
