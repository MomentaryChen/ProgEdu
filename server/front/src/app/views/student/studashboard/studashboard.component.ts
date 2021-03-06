import { Component, OnInit } from '@angular/core';
import { StudashboardService } from './studashboard.service';
import { JwtService } from '../../../services/jwt.service';
import { User } from '../../../models/user';
@Component({
  selector: 'app-studashboard',
  templateUrl: './studashboard.component.html'
})
export class StudashboardComponent implements OnInit {
  public assignmentTable: Array<any> = new Array<any>();
  public studentCommitRecord: JSON;
  public username: string;
  constructor(private studashboardService: StudashboardService, private jwtService?: JwtService) { }
  async ngOnInit() {
    this.username = new User(this.jwtService).getUsername();
    await this.getAllAssignments();
    await this.getStudentCommitRecords();
  }

  async getAllAssignments() {
    this.studashboardService.getAllAssignments().subscribe(response => {
      this.assignmentTable = response.allAssignments;
    });
  }

  async getStudentCommitRecords() {
    // clear student array
    this.studashboardService.getStudentCommitRecord(this.username).subscribe(response => {
      this.studentCommitRecord = response;
    });
  }

  isRelease(release: Date) {
    const now_time = new Date().getTime();
    const realease_time = new Date(this.getUTCAdjustTime(release)).getTime();
    if (now_time >= realease_time) {
      return true;
    }
    return false;
  }

  getUTCAdjustTime(time: any): Date {
    const timeOffset = (new Date().getTimezoneOffset() * 60 * 1000);
    const assigenmentTime = new Date(time).getTime();

    return new Date(assigenmentTime - timeOffset);
  }

  isNA(commit: any) {
    if (JSON.stringify(commit.commitRecord) !== '{}') {
      return false;
    }
    return true;
  }

}
