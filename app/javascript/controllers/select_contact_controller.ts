import { Controller } from '@hotwired/stimulus';

type FrameElement = HTMLElement & { src: string };

export default class SelectContactController extends Controller {
  private static readonly openDropDownClass = 'is-active';

  private static readonly activeDropdownItemClass = 'is-active';

  static targets = ['dropdown', 'contactOptionsFrame', 'filterInput', 'option', 'selectedValueField', 'selectedLabel'];

  static values = { updateUrl: String };

  private dropdownTarget!: HTMLElement;

  private contactOptionsFrameTarget!: FrameElement;

  private filterInputTarget!: HTMLInputElement;

  private optionTargets!: HTMLElement[];

  private selectedValueFieldTarget!: HTMLInputElement;

  private selectedLabelTarget!: HTMLElement;

  private updateUrlValue!: string;

  private abortWindowListenerController?: AbortController;

  public toggle(event: Event): void {
    event.preventDefault();
    if (this.isDropdownOpen()) {
      this.closeDropdown();
    } else {
      this.openDropdown();
    }
  }

  public filterChange(): void {
    this.updateContactOptionsFrameSrc();
  }

  public windowClick(event: MouseEvent): void {
    if (!this.dropdownTarget.contains(event.target as HTMLElement)) {
      this.closeDropdown();
    }
  }

  public select(event: Event & { target: HTMLElement }): void {
    event.preventDefault();

    const { target } = event;
    const { dataset: { value: selectedValue } } = target;
    const labelOfSelected = target.innerText;

    this.selectedValueFieldTarget.value = selectedValue || '';
    this.selectedLabelTarget.innerText = labelOfSelected;
    this.optionTargets
      .filter(e => e !== target)
      .forEach(e => e.classList.remove(SelectContactController.activeDropdownItemClass));
    target.classList.add(SelectContactController.activeDropdownItemClass);

    this.closeDropdown();
  }

  private isDropdownOpen(): boolean {
    return this.dropdownTarget.classList.contains(SelectContactController.openDropDownClass);
  }

  private openDropdown(): void {
    this.dropdownTarget.classList.add(SelectContactController.openDropDownClass);
    this.filterInputTarget.focus();
    if (this.abortWindowListenerController === undefined) {
      this.abortWindowListenerController = new AbortController();
      window.addEventListener('click', (event: MouseEvent) => this.windowClick(event), {
        signal: this.abortWindowListenerController.signal,
      });
    }
  }

  private closeDropdown(): void {
    this.dropdownTarget.classList.remove(SelectContactController.openDropDownClass);
    if (this.abortWindowListenerController !== undefined) {
      this.abortWindowListenerController.abort();
      this.abortWindowListenerController = undefined;
    }
  }

  private updateContactOptionsFrameSrc(): void {
    const filterFieldName = this.filterInputTarget.name;
    const filterValue = this.filterInputTarget.value;
    const selectedFieldName = this.selectedValueFieldTarget.name;
    const selectedValue = this.selectedValueFieldTarget.value;

    const url = new URL(this.updateUrlValue);
    url.searchParams.set(filterFieldName, filterValue);
    url.searchParams.set(selectedFieldName, selectedValue);

    this.contactOptionsFrameTarget.src = url.toString();
  }
}
