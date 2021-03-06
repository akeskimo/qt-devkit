#!/usr/bin/env python3

import os
import sh
import json
from typing import List, Dict, Any


def load_config():
    path = os.path.abspath(os.path.join(os.path.dirname(__file__), "config.json"))
    with open(path, "rb") as fh:
        return fh.read()


class ParsedJSON:
    """ Helper class for allowing accessing JSON values by attributes."""
    def __init__(self, data, *args, **keys):
        self.__dict__ = json.loads(data)

    def __str__(self):
        return str(self.__dict__)

    def __repr__(self):
        return str("<%s> %s" % (self.__class__.__name__, self.__dict__))


class Config(ParsedJSON):
    def __init__(self, *args, **keys):
        self.url = ""
        self.port = ""
        super().__init__(*args, **keys)


class Change(ParsedJSON):
    def __init__(self, *args, **keys):
        super().__init__(*args, **keys)


class GerritSSHClient:
    def __init__(self, config: Config):
        self.ssh = sh.ssh.bake("codereview.qt-project.org", ["-oBatchMode=yes", "-p", config.port])

    def list_commits(self) -> List[Change]:
        changes: List[Change] = []
        data = self.ssh("gerrit", "query", "status:open owner:self", "--current-patch-set", "--format", "JSON")
        for line in data.splitlines():
            change: Change = Change(line)

            try:
                change.project
            except AttributeError:
                continue

            changes.append(change)
        return changes

    def print_commits(self, key=None):
        commits = self.list_commits()
        if key is not None:
            commits = sorted(commits, key=key)
        for change in commits:
            print(change.currentPatchSet["revision"], change.subject)


def print_commits(args):
    config = Config(load_config())
    gerrit = GerritSSHClient(config)

    sorter = None
    if args.sort_by:
        if args.sort_by == "time":
            sorter = lambda x: x.createdOn
        elif args.sort_by == "subject":
            sorter = lambda x: x.subject
    gerrit.print_commits(sorter)

if __name__ == "__main__":

    import argparse, sys
    parser = argparse.ArgumentParser(prog="Command line helper to display patches from Gerrit.")
    parser.set_defaults(func=lambda x: parser.print_help())
    subparsers = parser.add_subparsers(title="Commands")
    print_parser = subparsers.add_parser("print")
    print_parser.add_argument("--sort-by", dest="sort_by", choices=["time", "subject"], default="")
    print_parser.set_defaults(func=print_commits)

    args = parser.parse_args(sys.argv[1:])
    args.func(args)
