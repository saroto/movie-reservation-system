import { IsString } from "class-validator";
import { Role } from "generated/prisma/client";

export class CreateUserDto {
    @IsString()
    username: string;
    @IsString()
    email: string;
    @IsString()
    passwordHash: string;
    @IsString()
    phoneNumber: string;
    @IsString()
    role: Role;
}
