import { Injectable } from "@nestjs/common";
import { JwtService, JwtSignOptions } from "@nestjs/jwt";
import { AppConfigService } from "../config/config.service";
export interface AccessTokenPayload {
    id: string;
    role: string;
    email: string;
    username: string;
}
export interface RefreshTokenPayload {
    id: string;
}
@Injectable()
export class TokenService {
    constructor(
        private readonly jwtService: JwtService,
        private readonly configService: AppConfigService
    ) { }

    signAccessToken(payload: AccessTokenPayload): string {
        return this.jwtService.sign(payload, {
            secret: this.configService.getJwtSecret(),
            expiresIn: this.configService.getAccessTokenExpiration(),

        } as JwtSignOptions);
    }

    signRefreshToken(payload: RefreshTokenPayload): string {
        return this.jwtService.sign(payload, {
            secret: this.configService.getRefreshTokenSecret(),
            expiresIn: this.configService.getRefreshTokenExpiration(),
        } as JwtSignOptions);

    }

    verifyAccessToken(token: string): Promise<AccessTokenPayload> {
        return this.jwtService.verifyAsync(token, {
            secret: this.configService.getJwtSecret(),
        }) as Promise<AccessTokenPayload>;
    }

    verifyRefreshToken(token: string): Promise<RefreshTokenPayload> {
        return this.jwtService.verifyAsync(token, {
            secret: this.configService.getRefreshTokenSecret(),
        }) as Promise<RefreshTokenPayload>;
    }

    getRefreshTokenExpiration(): Date {
        return new Date(Date.now() + this.parseDurationMs(this.configService.getRefreshTokenExpiration()));
    }

    private parseDurationMs(duration: string): number {
        const match = /^(\d+)(s|m|h|d|w)$/.exec(duration.trim());
        if (!match) {
            const seconds = Number(duration);
            return Number.isFinite(seconds) ? seconds * 1000 : 0;
        }
        const value = Number(match[1]);
        const unitMs: Record<string, number> = {
            s: 1000,
            m: 60 * 1000,
            h: 60 * 60 * 1000,
            d: 24 * 60 * 60 * 1000,
            w: 7 * 24 * 60 * 60 * 1000,
        };
        return value * unitMs[match[2]];
    }

} 