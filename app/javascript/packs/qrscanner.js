import './mobile/qr-scanner.sass'
import QrScanner from 'qr-scanner/qr-scanner.min.js'

import workerAsString from '!!raw-loader!qr-scanner/qr-scanner-worker.min'
const workerUrl = window.URL.createObjectURL(new Blob([workerAsString]))
QrScanner.WORKER_PATH = workerUrl
// Лежит в public/
// QrScanner.WORKER_PATH = 'qr_scanner/qr-scanner-worker.min.js'

window.QrScanner = QrScanner

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
