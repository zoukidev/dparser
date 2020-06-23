import * as path from 'path';
import FileReader from './utils/filereader';
import Extractor from './utils/extractor';

export default class Build {
    static build(folderPath: string) {
        if (FileReader.checkFolder(folderPath)) {
            Extractor.browsePackageData(folderPath);
        }
    }
}

(() => {
    Build.build(path.join(__dirname, '__Packages'));
})();