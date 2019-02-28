module application;

import tkd.tkdapplication;

class Application : TkdApplication
{
    private void exitCommand(CommandArgs args)
    {
        this.exit();
    }

    // Left pane
    // Where the spreadsheets/solvers can be opened.
    // Solvers will be in the for of a treeview
    private TreeView getLeftPane(PanedWindow parent)
    {
        auto solverNodesTree = new TreeView(parent).setHeading("Solvers").setStretch(true)
            .pack(0, 10, GeometrySide.left, GeometryFill.both, AnchorPosition.center);

        auto rowOpenChannel = new TreeViewRow(["Open Channel"], true, ["openchannel"]);

        TreeViewRow[] childrenOpenChannel;

        childrenOpenChannel.length = childrenOpenChannel.length + 1;
        childrenOpenChannel[0] = new TreeViewRow(["Rectangular Channel"], true,
                ["rectangularopenchannel"]);

        rowOpenChannel.children = childrenOpenChannel;

        auto rowDiversionWeirs = new TreeViewRow(["Diversion Weirs"], true, ["diversionweirs"]);

        TreeViewRow[] childrenDiversionWeirs;

        childrenDiversionWeirs.length = childrenDiversionWeirs.length + 1;
        childrenDiversionWeirs[0] = new TreeViewRow(["Sharp-Crested Weir"], true, ["sharpcrested"]);
        childrenDiversionWeirs.length = childrenDiversionWeirs.length + 1;
        childrenDiversionWeirs[1] = new TreeViewRow(["Broad-Crested Weir"], true, ["broadcrested"]);
        childrenDiversionWeirs.length = childrenDiversionWeirs.length + 1;
        childrenDiversionWeirs[2] = new TreeViewRow(["Ogee Weir"], true, ["ogee"]);

        rowDiversionWeirs.children = childrenDiversionWeirs;

        solverNodesTree.addRow(rowOpenChannel);
        solverNodesTree.addRow(rowDiversionWeirs);

        return solverNodesTree;
    }

    override protected void initInterface()
    {
        this.mainWindow.setTitle = "HydroDesk";

        // Get screen size
        auto scWidth = this.mainWindow.getScreenWidth;
        auto scHeight = this.mainWindow.getScreenHeight;

        // Set the size to maximized screen
        this.mainWindow.setGeometry(scWidth, scHeight, 0, 0);

        auto mainPanedWindow = new PanedWindow(this.mainWindow, Orientation.horizontal);

        auto leftPane = getLeftPane(mainPanedWindow);

        auto centerPane = new Frame(mainPanedWindow).setWidth(700).setHeight(600);

        mainPanedWindow.addPane(leftPane);
        mainPanedWindow.addPane(centerPane);
        mainPanedWindow.setPaneWeight(0, 1);
        mainPanedWindow.setPaneWeight(1, 5);

        mainPanedWindow.pack(0, 0, GeometrySide.top, GeometryFill.both,
                AnchorPosition.center, true);
    }
}
