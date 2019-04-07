function ErrorNotification(message) {
  this.message = message;
}

ErrorNotification.prototype.render = function render() {
  return new Notification(this.message, 'danger').render();
};
