import { Component, OnInit, OnDestroy, ViewChild } from '@angular/core';
import { environment } from '../../../../environments/environment';
import { Router } from '@angular/router';
import { FormControl, FormGroup, FormBuilder, Validators } from '@angular/forms';
import { CreateAssignmentService } from './create-assignment.service';
import { ModalDirective } from 'ngx-bootstrap/modal';

@Component({
  selector: 'app-create-assignment',
  templateUrl: './create-assignment.component.html'
})
export class CreateAssignmentComponent implements OnInit, OnDestroy {
  status: { isOpen: boolean } = { isOpen: false };
  disabled: boolean = false;
  isDropup: boolean = true;
  autoClose: boolean = false;
  assignment: FormGroup;
  items: string[] = [
    'The first choice!',
    'And another choice for you.',
    'but wait! A third!'
  ];

  errorMsg: string;
  SERVER_URL: string = environment.SERVER_URL;

  max: number = 100;
  showWarning: boolean;
  dynamic: number = 60;
  type: string = 'Waiting';

  stacked: any[] = [];

  timer: any = null;
  buttonCaption: string = 'Start';
  constructor(private router: Router, private fb: FormBuilder, private createService: CreateAssignmentService) { }
  @ViewChild('myModal', { static: true }) public progressModal: ModalDirective;
  @ViewChild('dangerModal', { static: false }) public errorModal: ModalDirective;


  ngOnInit() {
    this.assignment = this.fb.group({
      name: ['', Validators.required],
      releaseTime: ['', Validators.required],
      deadline: ['', Validators.required],
      readMe: ['', Validators.required],
      type: ['Maven', Validators.required],
      file: File,
    });
  }

  changeToAssignmentPage() {
    this.router.navigate(['./dashboard/assignmentManagement']);
  }

  fileListener($event) {
    this.assignment.value.file = $event.target.files[0];
  }

  public submit() {
    this.progressModal.show();
    console.log(this.assignment.value);

    this.createService.createAssignment(this.assignment).subscribe(
      (response) => {
        this.router.navigate(['./dashboard/assignmentManagement']);
      },
      error => {
        this.errorMsg = error.message;
        this.progressModal.hide();
        this.errorModal.show();
        console.log(error);
      });
  }


  ngOnDestroy() {
    this.status.isOpen = false;
  }

  onHidden(): void {
    console.log('Dropdown is hidden');
  }
  onShown(): void {
    console.log('Dropdown is shown');
  }
  isOpenChange(): void {
    console.log('Dropdown state is changed');
  }

  toggleDropdown($event: MouseEvent): void {
    $event.preventDefault();
    $event.stopPropagation();
    this.status.isOpen = !this.status.isOpen;
  }

  change(value: boolean): void {
    this.status.isOpen = value;
  }

}
