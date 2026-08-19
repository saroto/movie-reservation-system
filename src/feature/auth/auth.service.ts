import { Injectable } from '@nestjs/common';

import { TokenService } from 'src/core/token/token.service';
import { RegisterDto } from './dto/register.dto';
import { loginDto } from './dto/login.dto';
import { ResponseDto } from './dto/response.dto';
import { AuthRepository } from './auth.repository';
import { UserService } from '../user/user.service';
@Injectable()
export class AuthService {
    constructor(
        private readonly tokenService: TokenService,
        private readonly authRepository: AuthRepository,
        private readonly userService: UserService
    ) { }

    async register(body: RegisterDto): Promise<ResponseDto> {
        const user = await this.userService.create(body);
        const accessToken = await this.tokenService.signAccessToken({ id: user.userId, role: user.role, email: user.email, username: user.username });
        const refreshToken = await this.tokenService.signRefreshToken({ id: user.userId });
        await this.authRepository.createRefreshToken({
            userId: user.userId,
            tokenHash: refreshToken,
            expiresAt: this.tokenService.getRefreshTokenExpiration()
        })
        return {
            userId: user.userId,
            accessToken,
            phoneNumber: user.phoneNumber,
            refreshToken,
            role: user.role,
            email: user.email,
            username: user.username
        }
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

    async logout(tokenId: number) {
        return this.authRepository.revokeRefreshToken(tokenId);
    }
}
