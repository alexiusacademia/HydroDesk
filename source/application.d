module application;

import tkd.tkdapplication;

import dialogs.newrectangularsection;

class Application : TkdApplication
{
    TreeViewRow[4] childrenOpenChannel;
    TreeViewRow[3] childrenDiversionWeirs;

    int leftPaneWidth;

    private void exitApplication(CommandArgs args)
    {
        this.exit();
    }

    private void newProject(CommandArgs args)
    {

    }

    private void openProject(CommandArgs args)
    {

    }

    private void newRectangularSection(CommandArgs args)
    {
        new RectangularChannelDialog(this.mainWindow, this.leftPaneWidth);
    }

    private void newTrapezoidalSection(CommandArgs args)
    {

    }

    private void newCircularSection(CommandArgs args)
    {

    }

    private void newIrregularSection(CommandArgs args)
    {

    }

    private void newSharpCrestedWeir(CommandArgs args)
    {

    }

    private void newBroadCrestedWeir(CommandArgs args)
    {

    }

    private void newOgeeWeir(CommandArgs args)
    {

    }

    private void showAbout(CommandArgs args)
    {
        MessageDialog aboutDialog = new MessageDialog(this.mainWindow, "About")
            .setMessage("HydroDesk")
            .setDetailMessage("Desktop solutions for hydraulics engineering and analysis.\n\n"
                ~ "v0.0.1\n\nSyncsoft Solutions (c) 2019");
        aboutDialog.show();
    }

    // Left pane
    // Where the spreadsheets/solvers can be opened.
    // Solvers will be in the for of a treeview
    private TreeView getLeftPane(PanedWindow parent)
    {
        auto solverNodesTree = new TreeView(parent).setHeading("Solvers").setStretch(true)
            .pack(0, 10, GeometrySide.left, GeometryFill.both, AnchorPosition.center);

        //---------------------
        // Open channel nodes
        //---------------------
        auto rowOpenChannel = new TreeViewRow(["Open Channel"], true, ["openchannel"]);

        childrenOpenChannel[0] = new TreeViewRow(["Rectangular Channel"], true,
                ["rectangularopenchannel"]);
        childrenOpenChannel[1] = new TreeViewRow(["Trapezoidal Channel"], true, ["trapezoidalopenchannel"]);
        childrenOpenChannel[2] = new TreeViewRow(["Circular Channel"], true, ["circularopenchannel"]);
        childrenOpenChannel[3] = new TreeViewRow(["Irregular Channel"], true, ["irregularopenchannel"]);

        rowOpenChannel.children = childrenOpenChannel;

        //---------------------
        // Diversion weirs nodes
        //---------------------
        auto rowDiversionWeirs = new TreeViewRow(["Diversion Weirs"], true, ["diversionweirs"]);

        childrenDiversionWeirs[0] = new TreeViewRow(["Sharp-Crested Weir"], true, ["sharpcrested"]);
        childrenDiversionWeirs[1] = new TreeViewRow(["Broad-Crested Weir"], true, ["broadcrested"]);
        childrenDiversionWeirs[2] = new TreeViewRow(["Ogee Weir"], true, ["ogee"]);

        rowDiversionWeirs.children = childrenDiversionWeirs;

        solverNodesTree.addRow(rowOpenChannel);
        solverNodesTree.addRow(rowDiversionWeirs);

        return solverNodesTree;
    }

    private void createMenu()
    {
        MenuBar menuBar = new MenuBar(this.mainWindow);

        const Menu fileMenu = new Menu(menuBar, "File", 0)
            .addEntry("New Project", &this.newProject)
            .addEntry("Open Project", &this.openProject)
			.addSeparator()
            .addEntry("Exit", &this.exitApplication);

        Menu openChannelMenu = new Menu()
            .addEntry("Rectangular Section", &this.newRectangularSection)
            .addEntry("Trapezoidal Section", &this.newTrapezoidalSection)
            .addEntry("Circular Section", &this.newCircularSection)
            .addEntry("Irregular Section", &this.newIrregularSection);

        Menu diversionWeirsMenu = new Menu()
            .addEntry("Sharp-Crested", &this.newSharpCrestedWeir)
            .addEntry("Broad-Crested", &this.newBroadCrestedWeir)
            .addEntry("Ogee", &this.newOgeeWeir);

        const Menu spreadsheetMenu = new Menu(menuBar, "Spreadsheets", 0)
            .addMenuEntry("Open Channel", openChannelMenu, 0)
            .addMenuEntry("Diversion Weirs", diversionWeirsMenu, 0);
        
        const Menu helpMenu = new Menu(menuBar, "Help", 0)
            .addEntry("About", &this.showAbout);
    
    }

    override protected void initInterface()
    {
        this.mainWindow.setTitle = "HydroDesk";

        // Get screen size
        auto scWidth = this.mainWindow.getScreenWidth;
        auto scHeight = this.mainWindow.getScreenHeight;

        // Set the size to maximized screen
        this.mainWindow.setGeometry(scWidth, scHeight, 0, 0);
        // this.mainWindow.setFullscreen(true);

        this.createMenu();

        auto mainPanedWindow = new PanedWindow(this.mainWindow, Orientation.horizontal);

        auto leftPane = getLeftPane(mainPanedWindow);

        auto centerPane = new Frame(mainPanedWindow).setWidth(700).setHeight(600);

        mainPanedWindow.addPane(leftPane);
        mainPanedWindow.addPane(centerPane);
        // mainPanedWindow.setPaneWeight(0, 1);
        // mainPanedWindow.setPaneWeight(1, 5);

        this.leftPaneWidth = leftPane.getWidth;

        mainPanedWindow.pack(0, 0, GeometrySide.top, GeometryFill.both,
                AnchorPosition.center, true);
    }
}
