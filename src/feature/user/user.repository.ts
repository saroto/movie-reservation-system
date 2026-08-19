import { Injectable } from "@nestjs/common";
import { PrismaService } from "src/core/database/prisma.service";
import { CreateUserDto } from "./dto/create-user.dto";

@Injectable()
export class UserRepository {
    constructor(private readonly prismaService: PrismaService) { }

    createUser(data: CreateUserDto) {
        return this.prismaService.user.create({ data });
    }

    findUserByEmail(email: string) {
        return this.prismaService.user.findUnique({ where: { email } });
    }

    findUserById(userId: number) {
        return this.prismaService.user.findUnique({ where: { userId } });
    }

    addAdmin(userId: number) {
        return this.prismaService.user.update({
            where: { userId },
            data: { role: "admin" }
        })
    }
}