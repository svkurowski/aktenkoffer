function Warning(message) {
  this.message = message;
}

Warning.prototype.render = function render() {
  return new Notification(this.message, 'warning').render();
};
