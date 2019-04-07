document.addEventListener('turbolinks:load', () => {
  const dropOverlay = document.querySelector('.file-drop-overlay');
  if (!dropOverlay) {
    return;
  }

  const fileInput = document.querySelector('.file-input');

  document.body.addEventListener('dragenter', event => {
    event.preventDefault();
    dropOverlay.classList.add('show');
  });

  document.body.addEventListener('dragover', event => {
    event.preventDefault();
    event.dataTransfer.dropEffect = 'copy';
  });

  document.body.addEventListener('drop', event => {
    event.preventDefault();

    dropOverlay.classList.remove('show');
    fileInput.files = event.dataTransfer.files;
    fileInput.dispatchEvent(new Event('change'));

    if (fileInput.getAttribute('data-submit-on-drop') === 'true') {
      Rails.fire(fileInput.form, 'submit');
    }
  });

  document.body.addEventListener('dragleave', event => {
    if (!event.clientX && !event.clientY) {
      dropOverlay.classList.remove('show');
    }
  });
});
