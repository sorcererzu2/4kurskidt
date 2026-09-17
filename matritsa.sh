#!/usr/bin/env bash
# matritsa.sh — barcha tugunlar orasidagi aloqani tekshiradi (N x N matritsa).
# Ishlatilishi:  bash matritsa.sh 5
#
# Belgilar:
#   OK      — javob keldi
#   502     — manba tugun maqsadga ulana olmadi (maqsad oʻchiq yoki nomi notoʻgʻri)
#   RAD     — manba tugunning oʻzi javob bermayapti (ulanish rad etildi)
#   TIMEOUT — 3 soniyada javob kelmadi (tugun pause holatida)

SON=${1:-3}

printf "%-14s" "manba\\maqsad"
for j in $(seq 1 "$SON"); do printf "%-9s" "tugun$j"; done
echo
printf -- "-%.0s" $(seq 1 $((14 + SON * 9))); echo

for i in $(seq 1 "$SON"); do
  PORT=$((8080 + i))
  printf "%-14s" "tugun$i"
  for j in $(seq 1 "$SON"); do
    if [ "$i" -eq "$j" ]; then
      printf "%-9s" "-"
      continue
    fi
    JAVOB=$(curl -s --max-time 3 "http://localhost:${PORT}/chaqir/tugun${j}")
    RC=$?
    if [ "$RC" -eq 28 ]; then
      printf "%-9s" "TIMEOUT"
    elif [ "$RC" -eq 7 ]; then
      printf "%-9s" "RAD"
    elif [ "$RC" -ne 0 ]; then
      printf "%-9s" "RC=$RC"
    else
      case "$JAVOB" in
        Salom*) printf "%-9s" "OK" ;;
        XATO*)  printf "%-9s" "502" ;;
        *)      printf "%-9s" "?" ;;
      esac
    fi
  done
  echo
done
