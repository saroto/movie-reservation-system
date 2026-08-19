import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/core/database/prisma.service';
@Injectable()
export class AuthRepository {
    constructor(private readonly prismaService: PrismaService) { }

    createRefreshToken(userId: number, tokenHash: string) {
        return this.prismaService.refreshToken.create({
            data: {
                userId,
                tokenHash: tokenHash,
            }
        });
    }

}