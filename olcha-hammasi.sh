#!/usr/bin/env bash
# olcha-hammasi.sh — barcha yoʻnalishlar boʻyicha p50/p95/p99 ni oʻlchaydi.
# Ishlatilishi:  bash olcha-hammasi.sh 5 200
#   $1 — tugunlar soni, $2 — har bir yoʻnalish uchun soʻrovlar soni

SON=${1:-3}
N=${2:-200}

echo "Yoʻnalish        n      p50(s)   p95(s)   p99(s)   max(s)"
echo "---------------------------------------------------------"
for i in $(seq 1 "$SON"); do
  PORT=$((8080 + i))
  for j in $(seq 1 "$SON"); do
    [ "$i" -eq "$j" ] && continue
    for k in $(seq 1 "$N"); do
      curl -s -o /dev/null -w "%{time_total}\n" "http://localhost:${PORT}/chaqir/tugun${j}"
    done | sort -n | awk -v yon="tugun$i->tugun$j" -v n="$N" '{a[NR]=$1}
      END { printf "%-16s %-6d %-8.4f %-8.4f %-8.4f %-8.4f\n",
            yon, n, a[int(NR*0.50)], a[int(NR*0.95)], a[int(NR*0.99)], a[NR] }'
  done
done
