require("@rails/ujs").start()
import QrScanner from 'qr-scanner/qr-scanner.min.js';
QrScanner.WORKER_PATH = 'qr_scanner/qr-scanner-worker.min.js'
window.QrScanner = QrScanner;