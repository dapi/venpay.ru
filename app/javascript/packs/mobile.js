require("@rails/ujs").start()
import 'bootstrap/dist/css/bootstrap'
import './mobile/qr-scanner.sass'
import QrScanner from 'qr-scanner/qr-scanner.min.js';
QrScanner.WORKER_PATH = 'qr_scanner/qr-scanner-worker.min.js'
window.QrScanner = QrScanner;
