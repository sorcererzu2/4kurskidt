# app.py — Amaliy 1. Sodda HTTP xizmat
import os, time, socket
from http.server import HTTPServer, ThreadingHTTPServer, BaseHTTPRequestHandler
import urllib.request

NOM = os.environ.get("NODE_NAME", socket.gethostname())

# Sunʼiy kechikish (3-topshiriq uchun). Sukut boʻyicha 0 — xizmat odatdagidek ishlaydi.
# compose faylida: environment: [ "KECHIKISH_MS=50" ]
KECHIKISH_MS = float(os.environ.get("KECHIKISH_MS", "0"))


class H(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path == "/salom":
            if KECHIKISH_MS > 0:
                time.sleep(KECHIKISH_MS / 1000.0)
            self.javob(f"Salom, men {NOM}")
        elif self.path.startswith("/chaqir/"):
            hedef = self.path.split("/")[2]
            t0 = time.perf_counter()
            try:
                r = urllib.request.urlopen(
                        f"http://{hedef}:8080/salom", timeout=2).read().decode()
                dt = (time.perf_counter() - t0) * 1000
                self.javob(f"{r} | kechikish: {dt:.2f} ms")
            except Exception as e:
                self.javob(f"XATO: {e}", 502)
        else:
            self.javob("topilmadi", 404)

    def javob(self, matn, kod=200):
        self.send_response(kod)
        self.send_header("Content-Type", "text/plain; charset=utf-8")
        self.end_headers()
        self.wfile.write(matn.encode())

    def log_message(self, *a):
        pass


if __name__ == "__main__":
    # ThreadingHTTPServer — bir vaqtda bir necha soʻrovni qabul qiladi.
    # Oddiy HTTPServer ishlatilsa, tugun1 tugun2 ni chaqirganda navbat hosil boʻladi.
    ThreadingHTTPServer(("0.0.0.0", 8080), H).serve_forever()
