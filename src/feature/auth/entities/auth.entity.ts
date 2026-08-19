import { Exclude, Expose, Transform } from "class-transformer";

export class AuthEntity {
    @Expose()
    userId: string;

    @Exclude()
    tokenHash: string;

    @Expose()
    @Transform(({ value }: { value: Date }) => value?.toISOString())
    expiresAt: Date;

    @Expose()
    @Transform(({ value }: { value: Date }) => value?.toISOString())
    revokedAt: Date | null;


}

export class AuthTokens {
    @Expose()
    accessToken!: string;

    @Expose()
    refreshToken!: string;
}

export class AuthUser {
    @Expose()
    id!: string;

    @Expose()
    email!: string;

    @Expose()
    role!: string;
}