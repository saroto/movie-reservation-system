import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/core/database/prisma.service';

@Injectable()
export class AuthRepository {
    constructor(private readonly prismaService: PrismaService) { }

    createRefreshToken(data: { userId: number, tokenHash: string, expiresAt: Date }) {
        return this.prismaService.refreshToken.create({ data });
    }

    findRefreshTokenByUserId(userId: number, tokenHash: string) {
        return this.prismaService.refreshToken.findFirst({
            where: {
                userId: userId,
                tokenHash,
                isRevoked: false,
                expiresAt: { gt: new Date() }
            }
        })
    }

    revokeRefreshToken(tokenId: number) {
        return this.prismaService.refreshToken.update({
            where: { tokenId },
            data: { isRevoked: true, revokedAt: new Date() }
        })
    }
}