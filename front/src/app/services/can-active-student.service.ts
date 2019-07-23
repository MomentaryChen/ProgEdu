import { Injectable } from '@angular/core';
import { Router, CanActivate } from '@angular/router';
import { LoginAuthService } from './login-auth.service';
import { HttpService } from './http.service';
import { JwtService } from './jwt.service';

@Injectable({
  providedIn: 'root'
})
export class CanActiveStudentService implements CanActivate {
  constructor(public router: Router, private loginAuth: LoginAuthService,
    private http: HttpService, private jwtService: JwtService) { }

  canActivate(): Promise<boolean> | boolean {
    return new Promise((resolve) => {
      this.loginAuth.isLoginByStudent().then((response) => {
        if (response.isLogin && !response.admin) {
          console.log('canActive student');
          resolve(true);
        } else {
          this.jwtService.removeToken();
          console.log('not authenticated');
          this.router.navigate(['login']);
          resolve(false);
        }
      });
    });
  }
}
