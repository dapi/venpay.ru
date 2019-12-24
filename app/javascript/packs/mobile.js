require("@rails/ujs").start()
import bugsnag from '@bugsnag/js'
import 'bootstrap/dist/css/bootstrap'
import './mobile/qr-scanner.sass'
import QrScanner from 'qr-scanner/qr-scanner.min.js'
QrScanner.WORKER_PATH = 'qr_scanner/qr-scanner-worker.min.js'
window.QrScanner = QrScanner
window.bugsnagClient = bugsnag('12924e72e422ebbba11c70db0f708e95')

document.addEventListener("DOMContentLoaded", function(event) {
  const onSuccess = (hasCamera) => {
    if (hasCamera) {
      console.log('Камера найдена')
    } else {
      bugsnagClient.notify(new Error('Камера не найдена'))
      alert('Камера не найдена')
    }
  }

  const onFailure = (e) => {
    bugsnagClient.notify(new Error('Ошибка подключения камеры'))
    alert('Ошибка подключения камеры')
    console.log('Ошибка подключения камеры', e)
  }

  QrScanner.
    hasCamera().
    then(onSuccess, onFailure)

  const label = document.getElementById('label-qr-code');
  const video = document.getElementById('scan-qr-code');

  // Если это не ссылка - так и писать
  // Если это НЕ ссылка на venpay - так и писать
  const onScanned = (result) => {
    label.innerText='Код прочитан! Переходим на страницу оплаты..'
    document.location.href = result
  }

  const scanner = new QrScanner(video, onScanned)
  scanner.start();
});
