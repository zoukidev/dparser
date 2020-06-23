import * as fs from 'fs';
import { parentPort } from 'worker_threads';

export default class FileReader {
    static fileExt: string = '.as';

    static checkFolder(folderPath: string): boolean {
        return fs.existsSync(folderPath);
    }

    static checkFile(filePath: string): boolean {
        return filePath.substr(filePath.length - FileReader.fileExt.length) === FileReader.fileExt;
    }

    static checkType(path: string): string {
        if (FileReader.checkFile(path)) {
            return 'file';
        } else {
            return 'folder';
        }
    }
}