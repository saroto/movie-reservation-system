import { IsEmail, IsNotEmpty, Min } from "class-validator";

export class loginDto {
    @IsEmail()
    @IsNotEmpty()
    email!: string;

    @Min(8)
    @IsNotEmpty()
    password!: string;
}