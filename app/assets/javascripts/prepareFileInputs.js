
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

      console.log('File(s) in drop zone');
      element.classList.add('test');
    }

    element.ondragover = (event) => {
      event.preventDefault();

      event.dataTransfer.dropEffect = 'copy';
    }

    element.ondrop = (event) => {
      event.preventDefault();

      console.log('DROP');
      input.files = event.dataTransfer.files;
    }

    element.ondragleave = () => {
      console.log('LEAVE');
      element.classList.remove('test');
    }
  });
});
