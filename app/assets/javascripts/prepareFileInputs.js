document.addEventListener('DOMContentLoaded', () => {
  const dropOverlay = document.querySelector('.file-drop-overlay');

  const fileElement = document.querySelector('.file.has-name');
  const fileInput = fileElement.querySelector('.file-input');

  fileInput.addEventListener('change', () => {
    if (!fileInput.files.length) {
      return;
    }

    const label = fileElement.querySelector('.file-name');
    label.innerHTML = fileInput.files[0].name;

    fileElement.classList.add('has-file-attached');
  });


  document.body.ondragenter = (event) => {
    event.preventDefault();

    dropOverlay.classList.add('show');
  }

  document.body.ondragover = (event) => {
    event.preventDefault();

    event.dataTransfer.dropEffect = 'copy';
  }

  document.body.ondrop = (event) => {
    event.preventDefault();

    dropOverlay.classList.remove('show');
    fileInput.files = event.dataTransfer.files;
  }

  document.body.ondragleave = (event) => {
    if (!event.clientX && !event.clientY) {
      dropOverlay.classList.remove('show');
    }
  }
});
