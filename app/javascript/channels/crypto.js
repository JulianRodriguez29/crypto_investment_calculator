document.addEventListener('turbolinks:load', function () {
  const cryptoTableBody = document.getElementById('crypto-table-body');

  if (cryptoTableBody) {
    App.crypto = App.cable.subscriptions.create('CryptoChannel', {
      received: function (data) {
        const cryptoPriceCell = document.querySelector(`.crypto-price[data-symbol="${data.symbol}"]`);
        if (cryptoPriceCell) {
          cryptoPriceCell.innerHTML = data.price;
        }
      },
    });
  }
});