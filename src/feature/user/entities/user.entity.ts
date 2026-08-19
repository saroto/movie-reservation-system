import { Exclude, Expose } from "class-transformer";

export class User {
    @Expose()
    userId: number;
    @Expose()
    email: string;
    @Exclude()
    passwordHash: string;
    @Expose()
    username: string;
    @Expose()
    role: string;
    @Expose()
    phoneNumber: string;
}
