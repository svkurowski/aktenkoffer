function Notification(message, type) {
  this.message = message;
  this.class = `is-${type}`;
}

Notification.prototype.render = function render() {
  document.createElement('p');

  const element = document.createElement('p');
  element.classList.add('notification', this.class, 'is-not-closable');
  element.textContent = this.message;

  document.body.appendChild(element);
};
