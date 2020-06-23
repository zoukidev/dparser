import * as fs from 'fs';

export default class FileReader {
    static checkFolder(folderPath: string): boolean {
        return fs.existsSync(folderPath);
    }

    static checkFile(filePath: string): Buffer {
        return fs.readFileSync(filePath);
    }
}