import { Injectable } from "@nestjs/common";
import { ConfigService } from '@nestjs/config';
@Injectable()
export class AppConfigService {
    constructor(private readonly configService: ConfigService) { }

    getDbUrl(): string {
        return this.configService.get<string>('DATABASE_URL');
    }

    getJwtSecret(): string {
        return this.configService.get<string>('JWT_SECRET');
    }

    getRefreshTokenSecret(): string {
        return this.configService.get<string>('REFRESH_TOKEN_SECRET');
    }

    getRefreshTokenExpiration(): string {
        return this.configService.get<string>('REFRESH_TOKEN_EXPIRATION');
    }

    getAccessTokenExpiration(): string {
        return this.configService.get<string>('ACCESS_TOKEN_EXPIRATION');
    }

    getSwaggerEnabled(): boolean {
        return this.configService.get<boolean>('SWAGGER_ENABLED');
    }

    getSwaggerEndpoint(): string {
        return this.configService.get<string>('SWAGGER_ENDPOINT');
    }

    getSwaggerUiEndpoint(): string {
        return this.configService.get<string>('SWAGGER_UI_ENDPOINT');
    }

    getswaggerUsername(): string {
        return this.configService.get<string>('SWAGGER_USERNAME');
    }

    getswaggerPassword(): string {
        return this.configService.get<string>('SWAGGER_PASSWORD');
    }

    getApiPrefix(): string {
        return this.configService.get<string>('API_PREFIX');
    }
}