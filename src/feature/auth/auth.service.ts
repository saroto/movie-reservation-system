import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/core/database/prisma.service';
import { TokenService } from 'src/core/token/token.service';
@Injectable()
export class AuthService {
    constructor(
        private readonly tokenService: TokenService,
        private readonly prismaService: PrismaService
    ) { }

    async register(body: any): Promise<any> {
        return
    }

    async login(body: any): Promise<any> {
        return
    }

    async refreshToken(body: any): Promise<any> {
        return
    }

    async accessToken(body: any): Promise<any> {
        return
    }

    async logout(body: any) {
        return
    }
}
