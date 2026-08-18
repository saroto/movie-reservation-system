import { IsEmail, IsNotEmpty, IsString } from 'class-validator';
import { ApiProperty } from '@nestjs/swagger';
export class RegisterDto {
    @ApiProperty({ description: 'Username of the user', example: 'john_doe' })
    @IsString()
    username: string;
    @IsString()
    @IsEmail()
    email: string;
    @IsString()
    password: string;
    @IsString()
    @IsString()
    role: string;
}