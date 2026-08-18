import { Request, Response, NextFunction } from 'express';

export function swaggerBasicAuth(username: string, password: string) {
    return (req: Request, res: Response, next: NextFunction) => {
        const authHeader = req.headers.authorization;

        if (!authHeader || !authHeader.startsWith('Basic ')) {
            res.setHeader('WWW-Authenticate', 'Basic realm="Swagger Documentation"');
            res.status(401).json({ message: 'Authentication required' });
            return;
        }

        const base64Credentials = authHeader.slice(6);
        const credentials = Buffer.from(base64Credentials, 'base64').toString(
            'utf-8',
        );
        const [requestUsername, requestPassword] = credentials.split(':');

        if (requestUsername === username && requestPassword === password) {
            next();
            return;
        }

        res.setHeader('WWW-Authenticate', 'Basic realm="Swagger Documentation"');
        res.status(401).json({ message: 'Invalid credentials' });
    };
}