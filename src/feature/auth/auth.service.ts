import { Injectable } from '@nestjs/common';

import { TokenService } from 'src/core/token/token.service';
import { RegisterDto } from './dto/register.dto';
import { loginDto } from './dto/login.dto';
import { ResponseDto } from './dto/response.dto';
@Injectable()
export class AuthService {
    constructor(
        private readonly tokenService: TokenService,

    ) { }

    async register(body: RegisterDto): Promise<ResponseDto> {
        return
    }

    async login(body: loginDto): Promise<ResponseDto> {
        return
    }

    async refreshToken(body: any): Promise<any> {
        return
    }

    async accessToken(body: any): Promise<any> {
        return
    }

    async logout(body: number) {
        return
    }
}
