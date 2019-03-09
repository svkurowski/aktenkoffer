document.addEventListener('DOMContentLoaded', () => {
  const fileElements = document.querySelectorAll('.file.has-name');
  fileElements.forEach(element => {
    const input = element.querySelector('.file-input');

    input.addEventListener('change', () => {
      if (!input.files.length) {
        return;
      }

      element.querySelector('.file-name').innerHTML = input.files[0].name;
    });

    element.ondragenter = (event) => {
      event.preventDefault();

      element.classList.add('is-hovering-with-file');
    }

    element.ondragover = (event) => {
      event.preventDefault();

      event.dataTransfer.dropEffect = 'copy';
    }

    element.ondrop = (event) => {
      event.preventDefault();

      input.files = event.dataTransfer.files;
    }

    element.ondragleave = () => {
      element.classList.remove('is-hovering-with-file');
    }
  });
});
